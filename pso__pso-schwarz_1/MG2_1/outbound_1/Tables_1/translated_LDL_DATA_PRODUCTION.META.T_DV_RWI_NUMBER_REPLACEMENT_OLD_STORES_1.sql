CREATE OR REPLACE TABLE ldl_data_production_meta.t_dv_rwi_number_replacement_old_stores_1 (
part_week INTEGER,
part_week_begin_dt DATE,
part_week_end_dt DATE,
closed_re_cnt INTEGER,
open_re_cnt INTEGER,
difference INTEGER,
failed INTEGER,
total INTEGER,
rule_code STRING(255),
rule_description STRING(255),
metric STRING(255),
dataelem STRING(255),
dataelem_value INTEGER,
collection_time TIMESTAMP
);