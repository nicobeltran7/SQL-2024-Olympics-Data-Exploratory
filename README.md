# SQL-2024-Olympics-Data-Exploratory

**Objective:** Turn raw Olympic results into crisp, defensible answers.  
This repo shows how I take messy results tables for **Tokyo 2020 (Summer)** and **Beijing 2022 (Winter)**, clean them with SQL, and deliver “fun-facts that matter” (totals, leaders, rankings) that a social team, newsroom, or BI group could ship the same day.

**Business case (story):**  
Imagine the Comms & Insights team is prepping an Olympics campaign. They need quick, trustworthy nuggets—*How many golds did Tokyo award? Who was the most decorated? Which sports dominated Beijing?*—plus reproducible queries so every number can be verified. My job is to:

- **Normalize** disparate CSVs (athletes, events, results) and create reusable views.
- **Answer stakeholder questions** with one query per question (rankings, counts, durations).
- **Publish shareable outputs** (CSV tables) that can feed dashboards, articles, or social posts.

**Why it’s useful:**  
- **Speed:** each answer is a single SQL file—easy to rerun for new Games.  
- **Trust:** assumptions and metric definitions are baked into the queries.  
- **Hand-off ready:** outputs live in `/results`, ready for BI tools or copy desks.

*(See “Business Questions” below for the exact prompts I answer.)*

## Business Questions

### Part 1 — Tokyo 2020 (Summer)
1) **How many medals** were awarded?  
   • How many of those were **Gold**?  
2) **Which athlete won the most medals** in Tokyo 2020?  
3) **How long are the Olympics on average?**  
   • Which are the **longest** and **shortest** Games ever?  
4) **Top 10 countries** with the **most gold medals**.

### Part 2 — Beijing 2022 (Winter)
1) Has any **city hosted both Winter & Summer** Games?  
2) **Youngest debutant** in Beijing 2022 — and the **oldest**?  
3) Which **sport had the most medal events** in 2022?  
4) **How many nations** won **at least one medal** in Tokyo 2020?

---

## Results (highlights)

### Tokyo 2020
- **Total medals:** **1,188**  
- **Gold medals:** **376**  
- **Nations with ≥1 medal:** **93**

**Top 10 countries by *gold* medals (Tokyo 2020)**

|    | country_name               |   count |
|---:|:---------------------------|--------:|
|  1 | People's Republic of China |      56 |
|  2 | United States of America   |      49 |
|  3 | Japan                      |      31 |
|  4 | ROC                        |      29 |
|  5 | Great Britain              |      27 |
|  6 | Germany                    |      26 |
|  7 | Norway                     |      22 |
|  8 | Australia                  |      20 |
|  9 | Netherlands                |      18 |
| 10 | France                     |      17 |

> I’ll add the “most-decorated athlete” and duration stats after running those specific queries.

### Beijing 2022
- **Dual host city:** **Beijing** (hosted **Summer 2008** and **Winter 2022**)  
- **Youngest debutant:** **alysa liu** (born **2008**)  
- **Oldest debutant:** **marit fjellanger boehm** (born **1988**)  
- **Sport with most medal events:** **Cross Country Skiing** (**42** medal events)

---

## Repository Structure
├─ README.md
├─ data/
│ ├─ athletes.csv
│ ├─ events.csv
│ └─ results.csv
├─ queries/
│ ├─ 01_staging_cleaning.sql
│ ├─ 10_tokyo2020_medal_totals.sql
│ ├─ 11_tokyo2020_top_athlete.sql
│ ├─ 12_games_duration_stats.sql
│ ├─ 13_tokyo2020_top10_gold_by_country.sql
│ ├─ 20_dual_host_cities.sql
│ ├─ 21_beijing2022_youngest_oldest_debut.sql
│ ├─ 22_beijing2022_sport_with_most_events.sql
│ └─ 23_tokyo2020_countries_with_medals.sql
└─ results/
├─ Tokyo 2020 medals.csv
├─ Tokyo 2020 gold medals count.csv
├─ Tokyo 2020 total medals by country.csv
├─ Gold Medals by Country.csv
├─ Medals by discipline.csv
├─ Athlete total medal count.csv
├─ Athletes Name and birthdate.csv
├─ Total countries with medals.csv
└─ (others)

## SQL Approach & Notes

- **Staging / Cleaning**
  - Normalize column names (`snake_case`), trim/case strings, cast dates & numerics.
  - Standardize **seasons** (`Summer`/`Winter`) and **NOC/country names** (e.g., map `ROC → Russia`, `Great Britain → United Kingdom` if needed).
  - Deduplicate results (guard against repeated rows per athlete/event/medal).
  - Build reusable views:
    - `v_results_clean` – core results with normalized medal labels.
    - `v_medals_by_athlete/country/sport` – pre-aggregated counts for fast queries.
    - `v_games_calendar` – per-Games `start_date`, `end_date`, `duration_days`.

- **Metric Definitions (explicit)**
  - **Medal counts (Tokyo/Beijing)**  
    ```sql
    SUM(CASE WHEN medal_type = 'Gold'   THEN 1 ELSE 0 END) AS gold,
    SUM(CASE WHEN medal_type = 'Silver' THEN 1 ELSE 0 END) AS silver,
    SUM(CASE WHEN medal_type = 'Bronze' THEN 1 ELSE 0 END) AS bronze,
    COUNT(*) AS total
    ```
  - **Top athlete / country**  
    Use `ROW_NUMBER() OVER (PARTITION BY games ORDER BY total_medals DESC)`; fallback to `ORDER BY ... LIMIT 1` if window functions aren’t available.
  - **Games duration**  
    `DATEDIFF(end_date, start_date) + 1 AS duration_days` from `v_games_calendar`.
  - **Sport with most medal events (Beijing 2022)**  
    `COUNT(*)` over medal-awarding event finals in 2022, grouped by sport/discipline.

- **Assumptions (documented in queries)**
  - Team events: **count per medal awarded** (i.e., each athlete on the team counts 1 medal).  
    > Alternative (not used here): “per team medal” by de-duplicating on event/team id.
  - Medal ties (e.g., two bronzes): count each awarded medal row.
  - Disqualifications/stripped medals are taken **as-is** from the source files.
  - Country/NOC aliases consolidated via a small mapping CTE/table.

- **Techniques Used**
  - CTEs for readability; conditional aggregation (`CASE WHEN`); window functions for ranks.
  - `LEFT JOIN` patterns to keep zero-medal nations in mix tables where desired.
  - Parameterizable filters (`@games_year`, `@season`) so the same query can run for 2020/2022/2024.

- **Reproducibility**
  - One **numbered** `.sql` per question (staging in `01_staging_cleaning.sql`).
  - Every analysis query returns a **final, export-ready** result set to `/results`.
  - Notes at the top of each file list inputs, assumptions, and output columns.


## Next Steps

- **Complete remaining outputs**
  - Add “most-decorated athlete (Tokyo 2020)” and Games duration stats to `/results`.
  - Publish a tiny `data_dictionary.md` and a `noc_mapping.sql` snippet.

- **Paris 2024 module**
  - Re-run the same questions for 2024 and add a comparison query:
    - medal deltas by country (`2024 vs 2020/2022`)
    - leaders by sport and age distributions.

- **Decision Dashboard**
  - One-page Power BI/Tableau: KPI cards (total medals/golds), medal table, top athletes/countries, duration trend, sport mix.
  - Link screenshots + (optional) public dashboard URL in the README.

- **Data Quality**
  - Add validation queries: duplicate rows, missing medal types, impossible dates, NOC codes not in mapping.
  - Simple anomaly flags (z-score/IQR) for countries with unexpected medal swings.

- **Packaging & Automation**
  - `requirements.txt` for the SQLite option + a `scripts/run_all.py` to rebuild `/results` in one command.
  - (Optional) parameterized stored procedure or view for “medal table by year/season” to reduce query duplication.

- **Analysis Extensions (nice-to-have)**
  - Weighted medal points (Gold=3, Silver=2, Bronze=1) leaderboard.
  - Per-capita or per-GDP medal rates by country.
  - Age/cohort profiles of medalists by sport/discipline.
