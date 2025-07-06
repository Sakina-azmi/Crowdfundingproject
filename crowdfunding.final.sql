-- create or use the database, then import imp and required tables and scripts,run the sql scripts(if present)--
-- 1.Convert the Date fields to Natural Time--
-- unlock safe updates--
SET SQL_SAFE_UPDATES = 0;
-- Add and convert Created Date
ALTER TABLE projects ADD COLUMN created_date DATETIME;
UPDATE projects SET created_date = FROM_UNIXTIME(created_at);
-- Add and convert Deadline Date
ALTER TABLE projects ADD COLUMN deadline_date DATETIME;
UPDATE projects SET deadline_date = FROM_UNIXTIME(deadline);
-- Add and convert Updated Date
ALTER TABLE projects ADD COLUMN updated_date DATETIME;
UPDATE projects SET updated_date = FROM_UNIXTIME(updated_at);
-- Add and convert State Changed Date
ALTER TABLE projects ADD COLUMN state_changed_date DATETIME;
UPDATE projects SET state_changed_date = FROM_UNIXTIME(state_changed_at);
-- Add and convert Successful Date (with null handling)
ALTER TABLE projects ADD COLUMN successful_date DATETIME;
UPDATE projects 
SET successful_date = FROM_UNIXTIME(successful_at)
WHERE successful_at IS NOT NULL AND successful_at > 0;
-- Add and convert Launched Date
ALTER TABLE projects ADD COLUMN launched_date DATETIME;
UPDATE projects SET launched_date = FROM_UNIXTIME(launched_at);
-- Re-enable safe updates
SET SQL_SAFE_UPDATES = 1;

-- 2.Build a Calendar Table--
DROP TABLE IF EXISTS calendar_table;
CREATE TABLE calendar_table (
    `date` DATE PRIMARY KEY,
    `year` INT,
    `monthno` INT,
    `monthfullname` VARCHAR(20),
    `quarter` VARCHAR(2),
    `year_month` VARCHAR(8),
    `weekday_no` INT,
    `weekdayname` VARCHAR(20),
    `financial_month` VARCHAR(4),
    `financial_quarter` VARCHAR(4)
);
-- Step 2: Find the date range from projects table
SET @min_date = (SELECT MIN(DATE(created_date)) FROM projects);
SET @max_date = (SELECT MAX(DATE(created_date)) FROM projects);
-- Step 3: Generate and insert all dates in range
INSERT INTO calendar_table (`date`)
SELECT DISTINCT DATE(dates.calendar_date) AS `date`
FROM (
    SELECT DATE_ADD(@min_date, INTERVAL numbers.seq DAY) AS calendar_date
    FROM (
        SELECT a.N + b.N*10 + c.N*100 + d.N*1000 AS seq
        FROM 
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c,
            (SELECT 0 AS N UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
             UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) d
    ) numbers
    WHERE numbers.seq <= DATEDIFF(@max_date, @min_date)
) dates;
-- Step 4: Update all derived columns with proper escaping
UPDATE calendar_table
SET 
    `year` = YEAR(`date`),
    `monthno` = MONTH(`date`),
    `monthfullname` = MONTHNAME(`date`),
    `quarter` = CONCAT('Q', QUARTER(`date`)),
    `year_month` = DATE_FORMAT(`date`, '%Y-%b'),
    `weekday_no` = DAYOFWEEK(`date`),
    `weekdayname` = DAYNAME(`date`),
    `financial_month` = 
        CASE 
            WHEN MONTH(`date`) >= 4 THEN 
                CASE 
                    WHEN MONTH(`date`)-3 < 10 THEN CONCAT('FM', MONTH(`date`)-3)
                    ELSE CONCAT('FM', MONTH(`date`)-3)
                END
            ELSE 
                CASE 
                    WHEN MONTH(`date`)+9 < 10 THEN CONCAT('FM', MONTH(`date`)+9)
                    ELSE CONCAT('FM', MONTH(`date`)+9)
                END
        END,
    `financial_quarter` = 
        CASE 
            WHEN MONTH(`date`) BETWEEN 4 AND 6 THEN 'FQ-1'
            WHEN MONTH(`date`) BETWEEN 7 AND 9 THEN 'FQ-2'
            WHEN MONTH(`date`) BETWEEN 10 AND 12 THEN 'FQ-3'
            ELSE 'FQ-4'
        END;

-- Verify the results
SELECT * FROM calendar_table ORDER BY `date` LIMIT 100;

-- 4.Convert the Goal amount into USD using the Static USD Rate
SELECT 
    ProjectID, 
    goal, 
    static_usd_rate, 
    goal * static_usd_rate AS goal_in_usd
FROM 
    projects;
    
-- Q5.Total Number of Projects based on outcome
SELECT 
    state, 
    COUNT(projectid) AS ProjectCount 
FROM 
    projects 
GROUP BY 
    state;
    -- Total Number of Projects based on Locations
SELECT 
    country, 
    COUNT(projectid) AS ProjectCount 
FROM 
    projects 
GROUP BY 
    country;
    -- total no.of projects by category
SELECT 
    c.name AS category_name,
    COUNT(p.projectid) AS projectcount 
FROM 
    projects p  
JOIN 
    category c ON p.category_id = c.id 
GROUP BY 
    c.name;
    
-- total no.of projects by year,month,quarter
SELECT
    EXTRACT(YEAR FROM Created_Date) AS year,
    EXTRACT(MONTH FROM Created_Date) AS month,
    QUARTER(Created_Date) AS quarter,
    COUNT(projectid) AS project_count
FROM
    projects
GROUP BY
    year, month, quarter
ORDER BY
    year, month;
    
-- Q-6.Amount raised
SELECT 
    SUM(pledged) AS total_amount_raised
FROM projects
WHERE state = 'successful';
-- No.of Backers
SELECT 
    SUM(backers_count) AS total_backers
FROM 
	 projects
WHERE 
     state = 'successful';
-- Avg Number of Days for successful projects
SELECT SUM(DATEDIFF(successful_date, created_date)) / COUNT(*) AS Avg_Days_for_success
FROM projects
WHERE state = 'Successful'
  AND successful_date IS NOT NULL
  AND created_date IS NOT NULL; -- not important--
   
-- 7.Top Successful Projects: Based on Number of Backers--
SELECT name, backers_count, pledged
FROM projects
WHERE state = 'successful'
ORDER BY backers_count DESC
LIMIT 10;
-- Based on Amount Raised --
SELECT name, pledged, backers_count
FROM projects
WHERE state = 'successful'
ORDER BY pledged DESC
LIMIT 10;

-- 8.Percentage of Successful Projects overall--
SELECT 
    (COUNT(CASE WHEN state = 'successful' THEN 1 END) * 100.0 / COUNT(*)) AS success_precentage
FROM projects;
 -- Success Percentage by Category--
SELECT 
    c.name AS category_name,
    ROUND(100.0 * SUM(CASE WHEN p.state = 'successful' THEN 1 ELSE 0 END) / COUNT(p.projectid), 2) AS success_percentage
FROM 
    projects p
JOIN 
    category c ON p.category_id = c.id
GROUP BY 
    c.name
ORDER BY 
    success_percentage DESC;

-- By Year
SELECT 
    YEAR(created_date) as year,
    COUNT(*) as total_projects,
    COUNT(CASE WHEN state = 'successful' THEN 1 END) as successful_projects,
    (COUNT(CASE WHEN state = 'successful' THEN 1 END) * 100.0 / COUNT(*)) 
    as success_percentage
FROM projects
GROUP BY YEAR(created_date)
ORDER BY year;

-- By Month
SELECT 
    YEAR(created_date) as year,
    MONTHNAME(created_date) as month,
    COUNT(*) as total_projects,
    COUNT(CASE WHEN state = 'successful' THEN 1 END) as successful_projects,
    (COUNT(CASE WHEN state = 'successful' THEN 1 END) * 100.0 / COUNT(*)) 
    as success_percentage
FROM projects
GROUP BY YEAR(created_date), MONTH(created_date), MONTHNAME(created_date)
ORDER BY year, MONTH(created_date);

-- Percentage of successful Projects by goal range
SELECT 
    CASE 
        WHEN goal BETWEEN 0 AND 100 THEN '0-100'
        WHEN goal BETWEEN 101 AND 1000 THEN '101-1000'
        WHEN goal BETWEEN 1001 AND 10000 THEN '1001-10000'
        ELSE '10000+' 
    END AS goal_range, 
    ROUND(100.0 * SUM(CASE WHEN state = 'Successful' THEN 1 ELSE 0 END) / COUNT(ProjectID), 2) AS success_percentage
FROM 
    projects 
GROUP BY 
    goal_range 
ORDER BY 
    success_percentage DESC;