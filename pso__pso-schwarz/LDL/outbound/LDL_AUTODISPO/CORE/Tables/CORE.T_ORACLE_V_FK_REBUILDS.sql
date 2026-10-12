CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_rebuilds (
country STRING(250),
rb_storerebuild_id BIGNUMERIC(38,0),
rb_store_nr BIGNUMERIC(38,0),
rb_datefrom BIGNUMERIC(38,0),
rb_dateto BIGNUMERIC(38,0),
rb_cooldownfrom BIGNUMERIC(38,0),
mod_date DATETIME,
source_extraction_tmsp TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);