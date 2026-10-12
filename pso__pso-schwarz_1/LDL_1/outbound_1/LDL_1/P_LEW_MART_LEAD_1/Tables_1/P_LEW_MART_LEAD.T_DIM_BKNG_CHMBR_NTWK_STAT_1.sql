CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_dim_bkng_chmbr_ntwk_stat_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
oven_id BIGNUMERIC(38,0),
oven_brand STRING(20) COLLATE 'und:ci',
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE,
connected_fg BIGNUMERIC(38,0)
);