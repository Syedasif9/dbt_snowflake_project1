# Production job postings pipeline (v2) - dbt +snowflake

![pipeline architecture](image.png)

A production dbt pipeline on Snowflake over 843,097 raw job-posting scrapes, rebuilt nightly by a scheduled job with zero secrets.

Shapes medallion layers into a tested star schema — 491,140 jobs at a declared grain
Tracks a year of salary history with SCD2 snapshots — 504,591 version rows
Loads incrementally and runs itself on a scheduled Snowflake Job — no tokens anywhere
