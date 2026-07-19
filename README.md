# Investment Fee Calculation Pipeline

An analytics engineering project that builds an end-to-end investment fee calculation pipeline using **dbt, SQL, and DuckDB**.

The project transforms raw investment fund and client holdings data into client-level management fee calculations through a structured ELT workflow, including staging, intermediate transformations, data quality testing, and final reporting models.

---

## Project Overview

Investment platforms typically calculate management fees based on:

* Client portfolio holdings
* Fund Net Asset Value (NAV)
* Total Assets Under Management (AUM)
* Tier-based fee structures

This project simulates that process by building a reusable data transformation pipeline.

The pipeline:

1. Loads raw fund, holdings, and fee configuration data
2. Cleans and standardizes source data using staging models
3. Calculates portfolio market value and client AUM
4. Applies tier-based fee rules
5. Produces client-level annual and monthly fee calculations

---

## Tech Stack

| Technology | Purpose                                   |
| ---------- | ----------------------------------------- |
| dbt        | Data transformation framework and testing |
| SQL        | Data modelling and transformation logic   |
| DuckDB     | Local analytical database                 |
| GitHub     | Version control and documentation         |

---

## Data Pipeline Architecture

```
Raw CSV Files
      |
      v
dbt Seeds
      |
      v
Staging Layer
      |
      v
Intermediate Layer
      |
      v
Mart Layer
      |
      v
Client Fee Calculation Output
```

---

## Data Model

### Staging Layer

The staging layer standardizes raw source data into clean analytical tables.

### stg_fund

Fund master information.

Columns:

* fund_id
* fund_name
* nav
* category
* risk

### stg_holdings

Client investment holdings.

Columns:

* holding_id
* client_id
* fund_id
* units

### stg_fee_tier

Management fee configuration.

Columns:

* tier
* minimum AUM
* maximum AUM
* basis points (bps)

---

## Intermediate Layer

### int_portfolio_value

Calculates market value for each client holding.

Formula:

```
Market Value = Units Held × Fund NAV
```

---

### int_client_aum

Aggregates portfolio value into client-level assets under management.

Example:

| client_id | total_aum |
| --------- | --------: |
| C001      |    100000 |
| C002      |    250000 |

---

### int_fee_tier_assignment

Determines the applicable management fee tier based on client AUM.

Example:

| client_id | total_aum | tier   | bps |
| --------- | --------: | ------ | --: |
| C001      |    100000 | Tier 1 |  50 |

---

## Mart Layer

### fct_fee_calculation

Final reporting table containing calculated investment management fees.

Output:

| Column      | Description            |
| ----------- | ---------------------- |
| client_id   | Client identifier      |
| total_aum   | Total portfolio value  |
| tier        | Applied fee tier       |
| bps         | Fee rate               |
| annual_fee  | Annual management fee  |
| monthly_fee | Monthly management fee |

Formula:

```
Annual Fee = AUM × BPS / 10,000

Monthly Fee = Annual Fee / 12
```

---

## Data Quality Testing

dbt tests are implemented to validate:

### Completeness

* Required fields cannot be null

Examples:

* client_id
* fund_id
* market_value
* fee tier

### Uniqueness

Ensures key fields maintain expected grain.

Examples:

* fund_id
* holding_id
* client_id level outputs

### Referential Integrity

Ensures relationships between datasets are valid.

Example:

```
holdings.fund_id
        |
        v
fund.fund_id
```

---

## Running the Project

### Install dependencies

```bash
pip install dbt-duckdb
```

### Load seed data

```bash
dbt seed
```

### Build models

```bash
dbt run
```

### Run data quality tests

```bash
dbt test
```

### Generate documentation

```bash
dbt docs generate
dbt docs serve
```

---

## Future Enhancements

Potential improvements:

* Add historical NAV snapshots using dbt snapshots
* Implement effective-date based fee rules
* Add incremental models for large transaction volumes
* Deploy pipeline to cloud data warehouse
* Create BI dashboard for fee revenue analysis

---

## Key Learning Outcomes

This project demonstrates:

* Building an ELT pipeline with dbt
* Applying dimensional modelling concepts
* Designing staging, intermediate, and mart layers
* Implementing automated data quality checks
* Translating finance business rules into scalable data transformations
