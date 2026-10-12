CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_kol_range_selection (
client_id BIGNUMERIC(38,0),
range_plan_cd STRING(20) COLLATE 'und:ci',
range_advertise_from BIGNUMERIC(38,0),
range_advertise_to BIGNUMERIC(38,0)
);