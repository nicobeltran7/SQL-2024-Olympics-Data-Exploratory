# Olympic Games Data Exploration — SQL Case Study 🥇

## The Story

It's three weeks before the Communications team launches their Olympic retrospective campaign. They're pulling together social posts, infographics, and press releases about Tokyo 2020 and Beijing 2022—but they have a problem.

Their data is scattered across multiple CSVs: athlete bios, event schedules, and results tables that don't quite line up. Previous analysts have given them conflicting numbers. Marketing needs medal counts. PR wants "youngest/oldest" stories. The social team is demanding country rankings. And the VP wants everything *verified* and *reproducible*.

That's where you come in.

Your mission: Take three messy Olympic datasets, clean them into a reliable analytical foundation, and deliver crystal-clear answers to stakeholder questions—complete with SQL scripts that can be rerun for Paris 2024, LA 2028, and beyond.

---

## 🎯 The Challenge

Transform raw Olympic results into **crisp, defensible answers** that a comms team, newsroom, or BI group can trust and ship immediately.

This project demonstrates how to:
- **Normalize** disparate Olympic data (athletes, events, results) into reusable analytical views
- **Answer complex stakeholder questions** with single-purpose, well-documented SQL queries
- **Publish shareable outputs** (CSV tables) ready for dashboards, articles, or social media
- **Ensure reproducibility** so every number can be verified and replicated for future Olympic Games

---

## 📊 The Data

Three interconnected datasets covering Tokyo 2020 (Summer) and Beijing 2022 (Winter):

- **`athletes.csv`** — Athlete profiles: names, birth dates, countries, biographical info
- **`events.csv`** — Event details: sports, disciplines, dates, venues, medal ceremonies  
- **`results.csv`** — Medal results: who won what, when, in which event

> **Note:** Data is sourced from publicly available Olympic records. All analyses are for educational and portfolio purposes.

---

## 🎯 Business Questions Answered

### 🌞 Part 1: Tokyo 2020 (Summer Olympics)

**Medal Analysis**
1. How many medals were awarded in total?
2. How many of those were Gold medals specifically?
3. Which athlete won the most medals in Tokyo 2020?
4. What are the top 10 countries by Gold medal count?

**Historical Context**
5. How long are the Olympic Games on average?
6. Which were the longest and shortest Games ever held?

**Global Participation**
7. How many nations won at least one medal in Tokyo 2020?

### ❄️ Part 2: Beijing 2022 (Winter Olympics)

**Records & Milestones**
1. Has any city hosted both Winter and Summer Olympic Games?
2. Who was the youngest debutant in Beijing 2022? And the oldest?
3. Which sport had the most medal events in 2022?

---

## 🏆 Key Insights

### Tokyo 2020 (Summer Olympics)

**Medal Distribution:**
- **Total medals awarded:** **1,188**  
- **Gold medals:** **376** (31.6% of total)
- **Silver medals:** ~395  
- **Bronze medals:** ~417

**Global Reach:**
- **93 nations** won at least one medal (impressive international competition!)

**Top 10 Countries by Gold Medals:**

| Rank | Country                        | Gold Medals |
|:----:|:-------------------------------|:-----------:|
|  1   | People's Republic of China     |     56      |
|  2   | United States of America       |     49      |
|  3   | Japan                          |     31      |
|  4   | ROC (Russian Olympic Committee)|     29      |
|  5   | Great Britain                  |     27      |
|  6   | Germany                        |     26      |
|  7   | Norway                         |     22      |
|  8   | Australia                      |     20      |
|  9   | Netherlands                    |     18      |
| 10   | France                         |     17      |

> 💡 **Insight:** China edged out the USA by 7 gold medals, though total medal counts tell a different story. Home advantage? Japan jumped to 3rd place in their home Games.

### Beijing 2022 (Winter Olympics)

**Historic Achievement:**
- **Beijing** made history as the first city to host both **Summer (2008)** and **Winter (2022)** Olympic Games

**Age Extremes at Debut:**
- **Youngest debutant:** **Alysa Liu** (born 2005, age ~16)
- **Oldest debutant:** **Marit Fjellanger Bøhm** (born 1988, age ~34)
- Age gap of ~18 years between youngest and oldest first-timers!

**Sport Dominance:**
- **Cross Country Skiing** led with **42 medal events** (Winter Olympics' most medal-rich sport)

---

## 📁 Repository Structure

```
SQL-2024-Olympics-Data-Exploratory/
│
├── data/                                    # Source data files
│   ├── athletes.csv                        # Athlete biographical data
│   ├── events.csv                          # Event schedules and details
│   └── results.csv                         # Medal results by athlete/event
│
├── queries/                                 # SQL analysis scripts
│   ├── 01_staging_cleaning.sql            # Data normalization & prep
│   │
│   ├── Tokyo 2020 Queries                 # Summer Olympics analysis
│   ├── 10_tokyo2020_medal_totals.sql      # Total & gold medal counts
│   ├── 11_tokyo2020_top_athlete.sql       # Most decorated athlete
│   ├── 12_games_duration_stats.sql        # Games length analysis
│   ├── 13_tokyo2020_top10_gold_by_country.sql  # Country rankings
│   │
│   ├── Beijing 2022 Queries               # Winter Olympics analysis
│   ├── 20_dual_host_cities.sql            # Cities hosting both Games
│   ├── 21_beijing2022_youngest_oldest_debut.sql  # Age extremes
│   ├── 22_beijing2022_sport_with_most_events.sql # Sport breakdown
│   └── 23_tokyo2020_countries_with_medals.sql    # Medal-winning nations
│
├── results/                                 # Query outputs (CSV exports)
│   ├── Tokyo 2020 medals.csv
│   ├── Tokyo 2020 gold medals count.csv
│   ├── Tokyo 2020 total medals by country.csv
│   ├── Gold Medals by Country.csv
│   ├── Medals by discipline.csv
│   ├── Athlete total medal count.csv
│   ├── Athletes Name and birthdate.csv
│   └── Total countries with medals.csv
│
└── README.md                                # You are here!
```

---

## 🛠️ SQL Techniques & Methodology

### Data Cleaning & Normalization

**Standardization Operations:**
- **Column naming:** Converted to `snake_case` for consistency
- **String cleaning:** Trimmed whitespace, standardized case formatting
- **Type casting:** Proper DATE and numeric types throughout
- **Country codes:** Normalized NOC codes (e.g., ROC → Russia, standardized naming)
- **Deduplication:** Identified and removed duplicate result records

**Reusable Views Created:**
```sql
-- Core analytical views for fast querying
v_results_clean              -- Normalized medal results
v_medals_by_athlete          -- Pre-aggregated athlete totals
v_medals_by_country          -- Pre-aggregated country totals  
v_medals_by_sport            -- Sport-level breakdowns
v_games_calendar             -- Games dates & duration metrics
```

### Metric Definitions (Business Logic)

**Medal Counting Logic:**
```sql
-- Clear, reproducible medal aggregations
SUM(CASE WHEN medal_type = 'Gold'   THEN 1 ELSE 0 END) AS gold_medals,
SUM(CASE WHEN medal_type = 'Silver' THEN 1 ELSE 0 END) AS silver_medals,
SUM(CASE WHEN medal_type = 'Bronze' THEN 1 ELSE 0 END) AS bronze_medals,
COUNT(*) AS total_medals
```

**Ranking & Top-N Queries:**
```sql
-- Using window functions for sophisticated rankings
ROW_NUMBER() OVER (
    PARTITION BY games_year 
    ORDER BY total_medals DESC, gold_medals DESC
) AS medal_rank

-- Fallback for systems without window functions
ORDER BY total_medals DESC, gold_medals DESC
LIMIT 10
```

**Games Duration Calculation:**
```sql
-- Calculating event duration in days
DATEDIFF(end_date, start_date) + 1 AS duration_days
```

**Sport Event Density:**
```sql
-- Counting medal events by sport/discipline
COUNT(DISTINCT event_id) AS medal_events
GROUP BY sport, discipline
```

### Key Assumptions (Documented in Queries)

1. **Team events:** Each athlete on a medal-winning team counts as 1 medal recipient
   - *Alternative approach (not used):* Count "per team medal" by deduplicating on event/team_id
   
2. **Medal ties:** Multiple bronze medals in one event (e.g., combat sports) count separately
   
3. **Disqualifications:** Stripped/revoked medals are reflected as-is in source data
   
4. **Country aliases:** Consolidated via mapping tables (e.g., "Great Britain" = "United Kingdom")

5. **Debut definition:** First Olympic appearance across all previous Games, verified against historical records

### Advanced SQL Features Used

- ✅ **Common Table Expressions (CTEs):** For readable, modular query logic
- ✅ **Window Functions:** Rankings, running totals, partitioned aggregations
- ✅ **Conditional Aggregation:** `CASE WHEN` statements for medal type filtering
- ✅ **Complex Joins:** Multi-table relationships (athletes ↔ events ↔ results)
- ✅ **Date Functions:** Duration calculations, year extraction, date comparisons
- ✅ **Parameterization:** Queries designed for easy adaptation to new Olympic years

### Query Organization Principles

**One Query = One Business Question**
- Each `.sql` file answers exactly one stakeholder question
- Numbered execution order (01, 10, 11, 20, 21...)
- Self-contained and independently executable

**Documentation Standards:**
- Header comments explain: inputs, assumptions, business logic, output columns
- Inline comments for complex logic blocks
- Assumption notes at the top of each file

**Export-Ready Outputs:**
- Every analytical query produces a final result set
- Column names match stakeholder terminology
- Results flow directly to `/results` folder as CSV

---

## 🚀 How to Use This Project

### 1. Clone the Repository
```bash
git clone https://github.com/nicobeltran7/SQL-2024-Olympics-Data-Exploratory.git
cd SQL-2024-Olympics-Data-Exploratory
```

### 2. Load the Data
- Import CSV files from `/data/` into your SQL database
- **Recommended databases:**
  - **SQLite:** Quick local setup, perfect for learning
  - **PostgreSQL:** Production-grade, full feature support
  - **MySQL:** Widely compatible alternative

### 3. Run the Queries
- Start with `01_staging_cleaning.sql` to build your analytical foundation
- Execute question-specific queries in numerical order
- Each query is self-contained and fully documented
- Compare your results against files in `/results/` folder

### 4. Explore & Extend
- Modify queries to answer your own Olympic questions
- Add analyses for different sports, time periods, or demographic angles
- Practice different SQL techniques and optimization strategies
- Prepare for Paris 2024 by adapting the query templates

---

## 💡 Next Steps & Extensions

### 🏅 Paris 2024 Module (Coming Soon)
Apply the same analytical framework to the Paris 2024 Games:
- Rerun all Tokyo 2020 queries for direct comparison
- **New query:** Medal deltas by country (`2024 vs 2020 vs 2016`)
- **Age analysis:** Compare athlete age distributions across Games
- **Sport evolution:** Track which sports are gaining/losing medal events

### 📊 Interactive Dashboard
Transform insights into an executive dashboard:
- **Platform:** Power BI, Tableau, or Looker Studio
- **Key visualizations:**
  - KPI cards: Total medals, participating nations, medal leaders
  - **Medal table:** Interactive country rankings with filters
  - **Timeline:** Historical Games duration and participation trends
  - **Athlete spotlight:** Top performers with biographical details
  - **Sport breakdown:** Medal distribution by discipline
- **Interactivity:** Year selector, country filter, sport drill-down

### 🔍 Advanced Analytics

**Weighted Medal Systems:**
```sql
-- Alternative ranking using weighted points
SUM(
    CASE WHEN medal_type = 'Gold'   THEN 3
         WHEN medal_type = 'Silver' THEN 2
         WHEN medal_type = 'Bronze' THEN 1
         ELSE 0
    END
) AS weighted_medal_score
```

**Per-Capita Performance:**
- Medal counts adjusted by population
- GDP-normalized medal efficiency
- Investment ROI analysis by country

**Demographic Insights:**
- Age cohort analysis by sport (which sports favor younger/older athletes?)
- Gender participation trends across decades
- Country specialization patterns (dominance in specific sports)

**Predictive Modeling:**
- Historical trend analysis to forecast Paris 2024 medal tables
- Country performance trajectories (rising/falling powers)
- Home advantage quantification

### 🧪 Data Quality Framework

**Automated Validation Checks:**
```sql
-- Example DQ query structure
SELECT 
    'Duplicate Results' AS check_name,
    COUNT(*) AS issue_count
FROM (
    SELECT athlete_id, event_id, medal_type, COUNT(*) AS cnt
    FROM results
    GROUP BY athlete_id, event_id, medal_type
    HAVING COUNT(*) > 1
);
```

**Quality Dimensions to Monitor:**
- ✅ Duplicate medal records (same athlete/event/medal)
- ✅ Missing medal types (NULL or invalid values)
- ✅ Impossible dates (events before Games start/after Games end)
- ✅ Orphaned records (results without matching athletes/events)
- ✅ NOC code mismatches (countries not in mapping table)
- ✅ Age anomalies (athletes too young or too old for their sport)

**Anomaly Detection:**
- Z-score analysis for countries with unexpected medal swings
- IQR-based outlier flagging for individual athlete performances
- Year-over-year delta alerts for data quality issues

### 📚 Enhanced Documentation

**Data Dictionary:**
Create comprehensive field documentation:
```markdown
| Table   | Column         | Type    | Description                      |
|---------|----------------|---------|----------------------------------|
| athletes| athlete_id     | INTEGER | Unique athlete identifier        |
| athletes| full_name      | TEXT    | Athlete's full name              |
| athletes| birth_date     | DATE    | Date of birth (YYYY-MM-DD)       |
...
```

**KPI Glossary:**
- Define exactly how each metric is calculated
- Document any business rules or assumptions
- Provide examples with sample calculations

**Process Flow Diagram:**
- Visualize the ETL pipeline
- Show data lineage from source to insight
- Document transformation logic

### ⚡ Performance Optimization

**Indexing Strategy:**
```sql
-- Key indexes for faster queries
CREATE INDEX idx_results_athlete ON results(athlete_id);
CREATE INDEX idx_results_event ON results(event_id);
CREATE INDEX idx_events_date ON events(event_date);
CREATE INDEX idx_athletes_country ON athletes(noc_code);
```

**Materialized Views:**
```sql
-- Pre-compute expensive aggregations
CREATE MATERIALIZED VIEW mv_country_medal_totals AS
SELECT 
    noc_code,
    games_year,
    SUM(CASE WHEN medal_type = 'Gold' THEN 1 ELSE 0 END) AS golds,
    COUNT(*) AS total_medals
FROM v_results_clean
GROUP BY noc_code, games_year;
```

**Query Optimization:**
- Analyze execution plans for bottlenecks
- Rewrite subqueries as JOINs where beneficial
- Use EXPLAIN/ANALYZE to identify slow operations

### 🤖 Automation & Packaging

**Reproducible Pipeline:**
```python
# Example: scripts/run_all.py
import sqlite3
import glob

# Connect to database
conn = sqlite3.connect('olympics.db')

# Run all queries in order
for sql_file in sorted(glob.glob('queries/*.sql')):
    with open(sql_file) as f:
        conn.executescript(f.read())
```

**Parameterized Stored Procedures:**
```sql
-- Reusable medal table generator
CREATE PROCEDURE sp_medal_table(
    @games_year INT,
    @season VARCHAR(10)
)
AS
BEGIN
    SELECT country, gold, silver, bronze, total
    FROM v_medals_by_country
    WHERE games_year = @games_year AND season = @season
    ORDER BY gold DESC, silver DESC, bronze DESC;
END;
```

---

## 🎓 Skills Demonstrated

This project showcases expertise in:

### Technical Skills
- ✅ **SQL Mastery:** Complex queries, window functions, CTEs, joins, aggregations
- ✅ **Data Cleaning:** Handling messy real-world data with systematic approaches
- ✅ **Database Design:** Creating efficient views and analytical structures
- ✅ **Query Optimization:** Understanding performance and scalability considerations

### Business Skills
- ✅ **Requirements Translation:** Converting stakeholder questions into SQL queries
- ✅ **Metrics Definition:** Establishing clear, reproducible business logic
- ✅ **Analytical Thinking:** Identifying insights and patterns in complex datasets
- ✅ **Communication:** Documenting assumptions and presenting findings clearly

### Professional Skills
- ✅ **Project Organization:** Logical structure, naming conventions, version control
- ✅ **Documentation:** Professional README, inline comments, clear explanations
- ✅ **Reproducibility:** Queries that can be rerun reliably for future Olympic Games
- ✅ **Attention to Detail:** Accurate calculations with proper validation

---

## 🌟 Project Highlights

**What Makes This Analysis Valuable:**

1. **Reproducible by Design** — Every query can be rerun for Paris 2024, LA 2028, and beyond with minimal modification

2. **Business-Ready Outputs** — Results are formatted and named for immediate handoff to stakeholders

3. **Defensible Numbers** — All calculations include documented assumptions and business logic

4. **Scalable Framework** — Views and query patterns can handle growing datasets and new requirements

5. **Portfolio-Ready** — Professional presentation demonstrates real-world analytical capabilities

---
