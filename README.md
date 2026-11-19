# dbt Snowflake AWS Project

A data transformation project that uses dbt with Snowflake to transform Airbnb data through bronze, silver, and gold layers. The repository also includes a lightweight Python environment managed with `uv`.

## Project overview

The dbt project reads staged Airbnb booking, listing, and host data from the `AIRBNB.STAGING` schema in Snowflake. It cleans and prepares the data, then builds analytical fact and reporting tables.

The transformation flow is:

```text
Snowflake AIRBNB.STAGING
├── BOOKINGS
├── LISTINGS
└── HOSTS
        │
        ▼
Bronze models
├── bronze_bookings
├── bronze_listings
└── bronze_hosts
        │
        ▼
Silver models
├── silver_bookings
├── silver_listings
└── silver_hosts
        │
        ▼
Gold models
├── fact
└── obt
```

## Repository structure

```text
.
├── aws_dbt_snowflake_project/
│   ├── dbt_project.yml          # dbt project configuration
│   ├── models/
│   │   ├── sources/             # Snowflake source definitions
│   │   ├── bronze/              # Raw/staged transformations
│   │   ├── silver/              # Cleaned and standardized transformations
│   │   └── gold/                # Fact and reporting models
│   ├── analyses/                # Ad hoc dbt analyses
│   ├── macros/                  # Reusable dbt macros
│   ├── seeds/                   # CSV seed data
│   ├── snapshots/               # Slowly changing dimension snapshots
│   └── tests/                   # Custom dbt tests
├── main.py                      # Example Python entry point
├── pyproject.toml               # Python project metadata and dependencies
├── uv.lock                      # Reproducible Python dependency lock file
└── .python-version              # Python version selection
```

## Model layers

### Bronze

The bronze models read directly from the source tables and materialize tables in the `BRONZE` schema:

- `bronze_bookings.sql`
- `bronze_hosts.sql`
- `bronze_listings.sql`

### Silver

The silver models clean and prepare the bronze data for analytical use:

- `silver_bookings.sql`
- `silver_hosts.sql`
- `silver_listings.sql`

### Gold

The gold layer builds business-facing output:

- `obt.sql` joins booking, listing, and host data into an operationally useful broad table.
- `fact.sql` builds the fact-oriented dataset for analytical use.
- The project configuration also defines the Gold ephemeral models area.

## Prerequisites

- Python 3.14 or newer
- dbt Core 1.12.6 or newer
- dbt Snowflake adapter 1.12.4 or newer
- Access to a Snowflake account
- A configured dbt profile for this project

Install the Python dependencies:

```bash
uv sync
```

## Snowflake and dbt configuration

Configure a dbt profile named `aws_dbt_snowflake_project` as referenced in `aws_dbt_snowflake_project/dbt_project.yml`.

The project expects the following source location:

- Database: `AIRBNB`
- Schema: `STAGING`
- Tables:
  - `LISTINGS`
  - `HOSTS`
  - `BOOKINGS`

The target schema and model materializations are configured in `dbt_project.yml`. Bronze and silver models are materialized as tables, while the Gold configuration includes table and ephemeral models.

## Running the project

Open the dbt project directory:

```bash
cd aws_dbt_snowflake_project
```

Verify the dbt connection:

```bash
dbt debug
```

Install dependencies declared by the dbt project:

```bash
dbt deps
```

Run all models:

```bash
dbt run
```

Run data tests:

```bash
dbt test
```

Build models and tests together:

```bash
dbt build
```

Generate and view the dbt documentation:

```bash
dbt docs generate
dbt docs serve
```

## Running the Python entry point

From the repository root:

```bash
uv run python main.py
```

## Development notes

- Keep source definitions in `models/sources/` aligned with the Snowflake staging objects.
- Add reusable SQL logic to `macros/`.
- Add model documentation and tests beside or in the relevant model directories.
- Use dbt variables and environment-based profiles for credentials; do not commit Snowflake passwords or access tokens.
- Run `dbt build` before merging transformation changes.

## License

No license has been specified for this repository.
