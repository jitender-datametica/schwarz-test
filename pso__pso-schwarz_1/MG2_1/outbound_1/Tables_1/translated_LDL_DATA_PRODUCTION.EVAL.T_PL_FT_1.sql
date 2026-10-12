CREATE OR REPLACE TABLE ldl_data_production_eval.t_pl_ft_1 (
AGGREGATE STRING(100) COLLATE 'und:ci',
dwh_node_cd STRING(20) COLLATE 'und:ci',
country_cd STRING(2) COLLATE 'und:ci',
dwh_cal_dt DATE,
loc_sid BIGNUMERIC(38,0),
recalc_fg BIGNUMERIC(38,0),
status_1 BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0),
create_tmsp DATETIME,
update_tmsp DATETIME,
start_tmsp DATETIME,
end_tmsp DATETIME
);