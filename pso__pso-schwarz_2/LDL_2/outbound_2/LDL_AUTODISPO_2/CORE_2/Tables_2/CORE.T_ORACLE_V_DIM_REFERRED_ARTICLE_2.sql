CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_referred_article_2 (
country_2 STRING(16777216),
ra_mainarticle BIGNUMERIC(38,0),
ra_referredarticle BIGNUMERIC(38,0),
ra_type STRING(16777216),
ra_active BIGNUMERIC(38,0),
ra_warehouse BIGNUMERIC(38,0),
ra_date_from BIGNUMERIC(38,0),
ra_date_to BIGNUMERIC(38,0),
ra_percent BIGNUMERIC(38,0),
deleted INTEGER,
mod_date DATETIME,
date_from DATE,
date_to DATE,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
) CLUSTER BY ra_date_from, ra_date_to, country_2;