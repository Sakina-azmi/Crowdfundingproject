# 🚀 Kickstarter Crowdfunding Analytics Project  

![Banner](https://capsule-render.vercel.app/api?type=waving&color=0:6a11cb,100:2575fc&height=200&section=header&text=Kickstarter%20Analytics%20Project&fontSize=35&fontColor=ffffff&animation=twinkling)  

📊 This project analyzes **Kickstarter crowdfunding data** to uncover trends, patterns, and factors that drive project success.  
The analysis leverages **SQL, Excel, Power BI, and Tableau** to explore project performance across categories, countries, funding goals, and time.  

---

## 📖 Table of Contents  
1. [Project Overview](#-project-overview)  
2. [Business Objectives](#-business-objectives)  
3. [Tools & Technologies](#-tools--technologies)  
4. [Data Preparation](#-data-preparation)  
5. [KPIs Analyzed](#-kpis-analyzed)  
6. [Dashboards](#-dashboards)  
7. [Key Insights](#-key-insights)  
8. [Business Recommendations](#-business-recommendations)  
9. [Learnings](#-learnings)  
10. [Repository Structure](#-repository-structure)  
11. [Future Enhancements](#-future-enhancements)  
12. [Connect with Me](#-connect-with-me)  

---

## 🚀 Project Overview  
Kickstarter is one of the world’s largest crowdfunding platforms, helping creators raise funds for creative and innovative projects.  
This dataset contains thousands of projects launched globally, with attributes such as:  

- 🎭 **Category & Sub-category** of projects  
- 🌍 **Country** of launch  
- 💰 **Goal amount vs Pledged amount**  
- ⏳ **Project duration** and timelines  
- 👥 **Number of backers**  
- 📊 **State** of project (successful, failed, canceled, live)  

The aim of this project is to simulate how a **Business/Data Analyst** would transform raw crowdfunding data into **actionable insights** that help stakeholders make better decisions.  

---

## 🎯 Business Objectives  
✔ Understand global crowdfunding performance (success vs failure rates)  
✔ Identify **factors that influence project success** (category, country, funding goal, duration)  
✔ Compare **categories and sub-categories** to see which ideas resonate with backers  
✔ Analyze **funding patterns across time** (yearly & monthly trends)  
✔ Build **interactive dashboards** for stakeholders (investors, creators, platform managers)  

---

## 🛠️ Tools & Technologies  
- **SQL (MySQL/PostgreSQL)** → Data cleaning, transformation, and querying  
- **Excel** → Data wrangling, pivot analysis, trend exploration  
- **Power BI** → KPI dashboards, DAX measures, trend analysis  
- **Tableau** → Storytelling dashboards & advanced visualizations  

---

## ⚙️ Data Preparation  
✔ Converted **UNIX timestamps → human-readable datetime**  
✔ Built a **custom calendar table** for time-based aggregations  
✔ Standardized all currency values to **USD** for comparability  
✔ Cleaned null values, duplicates, and inconsistent category names  
✔ Created **calculated measures**: project duration, profit ratio, success percentage  
✔ Validated data integrity for accurate reporting  

---

## 🏁 KPIs Analyzed  
- 📌 **Total Projects** → by state (Successful, Failed, Canceled, Live)  
- 📌 **Projects by Category & Sub-Category** → success vs failure trends  
- 📌 **Projects by Country** → top performing regions globally  
- 📌 **Funding Analysis** → pledged amount vs goal amount  
- 📌 **Backers Analysis** → total backers, top projects by engagement  
- 📌 **Time Analysis** → projects per year, quarter, month  
- 📌 **Duration Analysis** → average campaign length & its impact on success  
- 📌 **Goal Range Analysis** → success percentage by funding goal bands (e.g., $0-$1k, $1k-$10k, $10k-$100k, $100k+)  

---

## 📊 Dashboards  

### 📈 Power BI Dashboard  
Interactive KPI dashboard including:  
- Funding trends over time  
- Project distribution by category & country  
- Goal vs pledged analysis  
- Backers engagement  

![Power BI Dashboard]<img width="326" height="245" alt="image" src="https://github.com/user-attachments/assets/22e7a85e-2058-4c98-b56f-1c6cb0f25fe6" />
  

---

### 📊 Tableau Story  
Storytelling dashboard with:  
- Success percentage by category  
- Heatmap of country-wise performance  
- Trend analysis of goal ranges vs success  
- Drill-downs for category sub-analysis  

![Tableau Dashboard]<img width="326" height="245" alt="image" src="https://github.com/user-attachments/assets/241139d1-94bd-4185-93e3-f99c38ba6b5f" />
  

---

## 🔑 Key Insights  
✔ **Technology** and **Games** dominate funding amounts but also face high competition.  
✔ Projects with **moderate goal amounts ($1k-$10k)** have the **highest success rates**.  
✔ **Film & Music projects** often succeed with smaller funding goals, showing strong community support.  
✔ **United States, UK, and Canada** contribute the most successful projects, while developing countries see higher failure rates due to limited backer reach.  
✔ Projects launched in **spring and summer months** showed slightly higher success than winter launches.  
✔ Campaigns with **short to medium duration (30–45 days)** performed better than very short or very long campaigns.  

---

## 💡 Business Recommendations  
✅ Encourage creators to **set realistic funding goals** ($1k-$10k for most categories).  
✅ Promote **Technology, Games, and Design projects** with high potential but guide them to avoid over-ambitious goals.  
✅ For countries with lower success, **Kickstarter could provide creator education** and localized marketing campaigns.  
✅ Creators should aim for **30–45 day campaign durations** for optimal engagement.  
✅ **Seasonal timing** could be leveraged → encourage launches in **Q2 & Q3** when success rates peak.  
✅ Offer **data-driven personalized tips** to project creators during setup.  

---

## 🧠 Learnings  
🔹 Hands-on experience with **data wrangling** (timestamp conversions, goal standardization)  
🔹 Designing **relevant KPIs** that align with stakeholder needs  
🔹 Creating **interactive dashboards** that tell a story  
🔹 Balancing **business context with technical execution**  
🔹 Strengthened skills in **SQL, Power BI, Tableau, and Excel analytics**  

---

## 📁 Repository Structure  
