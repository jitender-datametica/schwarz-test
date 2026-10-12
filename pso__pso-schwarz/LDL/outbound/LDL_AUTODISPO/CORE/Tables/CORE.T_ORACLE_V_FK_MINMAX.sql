CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_minmax (
country STRING(16777216),
mm_wh BIGNUMERIC(38,0),
mm_gen_time_id BIGNUMERIC(38,0),
mm_order_type_id BIGNUMERIC(38,0),
mm_order_type STRING(16777216),
mm_packageamount BIGNUMERIC(38,10),
mm_packageamount_min BIGNUMERIC(38,10),
mm_packageamount_max BIGNUMERIC(38,10),
mod_date DATETIME,
mm_calculationmethod BIGNUMERIC(38,0),
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL,
date_ DATE
) CLUSTER BY date_, country, mm_wh;