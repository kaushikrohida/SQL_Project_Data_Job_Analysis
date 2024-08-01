# Introduction
Dive into the data job market! This project focuses on data analyst roles, offering a comprehensive exploration of top-paying jobs, essential in-demand skills, and regions where high demand meets high salaries in the field of data analytics. By analyzing current industry trends and job market data, this project aims to provide a clear picture of the landscape, helping data analysts make informed career decisions.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paying jobs and in-demand skills. By thoroughly analyzing industry trends and job market data, we aim to provide valuable insights that can streamline the job search process for others. This project seeks to equip aspiring data analysts with the knowledge they need to find optimal job opportunities and develop the skills that are most valued in the industry.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn? 

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, enabling me to query databases and unearth critical insights.

- **PostgreSQL:** The chosen database management system, ideal for handling job posting data.
- **Visual Studio Code:** My go-to tool for database management and executing SQL queries.

- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, facilitating collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.

Here's how I approchaed each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact jpf
LEFT JOIN company_dim cd
    ON jpf.company_id = cd.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.

- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.

- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specialization within data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact jpf
    LEFT JOIN company_dim cd
        ON jpf.company_id = cd.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tpj.*,
    sd.skills
FROM top_paying_jobs tpj
INNER JOIN skills_job_dim sjd
    ON tpj.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
ORDER BY
    salary_year_avg DESC
```
Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings:

- **Common Skills:** SQL and Python are the most commonly required skills across these roles, indicating their importance in data analysis and insights roles.

- **Visualization Tools:** Tableau is frequently listed, highlighting the need for data visualization skills.

- **Specialized Tools:** Various roles require specific tools and platforms like Azure, AWS, Databricks, Snowflake, and others, showing the need for diverse technical expertise.

- **Software and Reporting Tools:** Skills in Excel, Power BI, and PowerPoint are also valued, especially for roles that likely involve presenting data and insights to stakeholders.

### 3. In-Demand Skills for Data Analyst
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT
    skills,
    COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here's the breakdown of the most demanded skills for data analysts in 2023

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.

- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

Here's the data formatted as a table:

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Tables of the demand for the top 5 skills in data analyst job posting*

### 4. Top Paying Skills
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salsary
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salsary DESC
LIMIT 25
```
Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Data & AI Skills:** PySpark commands the highest average salary at $208,172, highlighting the demand for big data processing expertise. AI and machine learning platforms such as Watson ($160,515) and DataRobot ($155,486) offer high salaries, reflecting the need for advanced analytics skills. Popular data science tools like Pandas ($151,821) and Scikit-learn ($125,781) are highly valued.

- **Specialized Tools and Technologies:** Version control systems and collaborative platforms such as Bitbucket ($189,155) and GitLab ($154,500) are important and well-compensated. Jupyter ($152,777) and ElasticSearch ($145,000) also command high salaries, indicating the significance of skills in interactive computing environments and search engines.

- **Programming and Development Skills:** Programming languages such as Swift ($153,750) and GoLang ($145,000) are highly valued, showing the demand for software development expertise. Data engineering and infrastructure skills like Databricks ($141,907) and Kubernetes ($132,500) highlight the need for expertise in data analytics platforms and container orchestration.

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
```

Here's the data formatted as a table:

| Skill ID | Skills     | Demand Count | Avg Salary ($) |
|----------|------------|--------------|----------------|
| 8        | Go         | 27           | 115,320        |
| 234      | Confluence | 11           | 114,210        |
| 97       | Hadoop     | 22           | 113,193        |
| 80       | Snowflake  | 37           | 112,948        |
| 74       | Azure      | 34           | 111,225        |
| 77       | BigQuery   | 13           | 109,654        |
| 76       | AWS        | 32           | 108,317        |
| 4        | Java       | 17           | 106,906        |
| 194      | SSIS       | 12           | 106,683        |
| 233      | Jira       | 20           | 104,918        |
| 79       | Oracle     | 37           | 104,534        |
| 185      | Looker     | 49           | 103,795        |
| 2        | NoSQL      | 13           | 101,414        |
| 1        | Python     | 236          | 101,397        |
| 5        | R          | 148          | 100,499        |
| 78       | Redshift   | 16           | 99,936         |
| 187      | Qlik       | 13           | 99,631         |
| 182      | Tableau    | 230          | 99,288         |
| 197      | SSRS       | 14           | 99,171         |
| 92       | Spark      | 13           | 99,077         |
| 13       | C++        | 11           | 98,958         |
| 186      | SAS        | 63           | 98,902         |
| 7        | SAS        | 63           | 98,902         |
| 61       | SQL Server | 35           | 97,786         |
| 9        | JavaScript | 20           | 97,587         |

*Table for the most optimal skills for data analyst sorted by salary and demand count.*

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand for Data and Programming Languages:** **Python** has the highest demand count (236) with an average salary of $101,397, showing its significance in the data analyst field. **R** also has a high demand count (148) with an average salary of $100,499, indicating its value for statistical analysis and data visualization. **Tableau** (230 demand count, $99,288 average salary) is a critical skill for data visualization.

- **Data Warehousing and Cloud Platform:** **Snowflake** (37 demand count, $112,948 average salary) and **Oracle** (37 demand count, $104,534 average salary) are highly demanded, highlighting the importance of data warehousing skills. **Cloud** platforms like **Azure** (34 demand count, $111,225 average salary) and **AWS** (32 demand count, $108,317 average salary) are essential for modern data infrastructure and analysis.

- **Specialized Tools and Languages:** • **Go** (27 demand count, $115,320 average salary) and **Java** (17 demand count, $106,906 average salary) are important for backend development and data processing. Tools like **Confluence** (11 demand count, $114,210 average salary) and **Jira** (20 demand count, $104,918 average salary) are valuable for project management and collaboration. **Looker** (49 demand count, $103,795 average salary) is significant for business intelligence and data analytics. 

# What I Learned
Throught this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **Comples Query Creafting::** Got more familiar with the art of advanced SQL, merging tables and wielding WITH clauses for table maneuvers.

- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.

- **Analytical Wizeardry:** Levelved up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conslusion

### Insights
1. **Top-Paying Data Analyst Jobs:** The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills:** SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries:** Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value:** SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing THoughts

This project not only enhanced my SQL skills but also provided valuable insights into the data analyst job market. The findings serve as a guide for prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration underscores the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
