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


--JSON File
/*
[
  {
    "skills": "pyspark",
    "avg_salsary": "208172"
  },
  {
    "skills": "bitbucket",
    "avg_salsary": "189155"
  },
  {
    "skills": "couchbase",
    "avg_salsary": "160515"
  },
  {
    "skills": "watson",
    "avg_salsary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salsary": "155486"
  },
  {
    "skills": "gitlab",
    "avg_salsary": "154500"
  },
  {
    "skills": "swift",
    "avg_salsary": "153750"
  },
  {
    "skills": "jupyter",
    "avg_salsary": "152777"
  },
  {
    "skills": "pandas",
    "avg_salsary": "151821"
  },
  {
    "skills": "elasticsearch",
    "avg_salsary": "145000"
  },
  {
    "skills": "golang",
    "avg_salsary": "145000"
  },
  {
    "skills": "numpy",
    "avg_salsary": "143513"
  },
  {
    "skills": "databricks",
    "avg_salsary": "141907"
  },
  {
    "skills": "linux",
    "avg_salsary": "136508"
  },
  {
    "skills": "kubernetes",
    "avg_salsary": "132500"
  },
  {
    "skills": "atlassian",
    "avg_salsary": "131162"
  },
  {
    "skills": "twilio",
    "avg_salsary": "127000"
  },
  {
    "skills": "airflow",
    "avg_salsary": "126103"
  },
  {
    "skills": "scikit-learn",
    "avg_salsary": "125781"
  },
  {
    "skills": "jenkins",
    "avg_salsary": "125436"
  },
  {
    "skills": "notion",
    "avg_salsary": "125000"
  },
  {
    "skills": "scala",
    "avg_salsary": "124903"
  },
  {
    "skills": "postgresql",
    "avg_salsary": "123879"
  },
  {
    "skills": "gcp",
    "avg_salsary": "122500"
  },
  {
    "skills": "microstrategy",
    "avg_salsary": "121619"
  }
]
*/