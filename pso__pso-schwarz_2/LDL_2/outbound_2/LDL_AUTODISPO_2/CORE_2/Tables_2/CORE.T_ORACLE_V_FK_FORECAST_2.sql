CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_forecast_2 (
forc_time_id BIGNUMERIC(38,10),
forc_quantity BIGNUMERIC(38,10),
country_2 STRING(16777216),
forc_store_nr BIGNUMERIC(38,10),
mod_date DATETIME,
forc_forc_time_id BIGNUMERIC(38,10),
forc_item_nr STRING(16777216),
forc_type BIGNUMERIC(38,10),
forc_h95 BIGNUMERIC(38,10),
deleted BIGNUMERIC(38,10),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
date_ DATE,
date_forc DATE
) CLUSTER BY date_, date_forc, country_2;