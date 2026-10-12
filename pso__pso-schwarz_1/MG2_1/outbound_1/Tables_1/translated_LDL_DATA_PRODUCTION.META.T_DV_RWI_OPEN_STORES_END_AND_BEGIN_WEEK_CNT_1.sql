CREATE OR REPLACE TABLE ldl_data_production_meta.t_dv_rwi_open_stores_end_and_begin_week_cnt_1 (
part_week INTEGER,
part_week_begin_dt DATE,
part_week_end_dt DATE,
open_re_end_of_week_cnt INTEGER,
open_re_begin_of_week_cnt INTEGER,
open_re_during_week_cnt INTEGER,
closed_re_during_week_cnt INTEGER,
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