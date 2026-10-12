CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_order_area (
client_id BIGNUMERIC(38,0) NOT NULL,
order_area_cd STRING(5) COLLATE 'und:ci' NOT NULL,
order_area_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);