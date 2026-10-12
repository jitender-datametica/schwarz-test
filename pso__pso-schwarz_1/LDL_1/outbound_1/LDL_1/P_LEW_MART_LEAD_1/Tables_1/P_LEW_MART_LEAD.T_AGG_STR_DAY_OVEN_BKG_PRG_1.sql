CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_str_day_oven_bkg_prg_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store_move_to BIGNUMERIC(38,0) NOT NULL,
aspect_id BIGNUMERIC(38,0) NOT NULL,
oven_id BIGNUMERIC(38,0) NOT NULL,
oven_brand STRING(20) COLLATE 'und:ci',
baking_prog_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_week BIGNUMERIC(38,0),
cy_month BIGNUMERIC(38,0),
busyear BIGNUMERIC(38,0),
cnt_bkg_prg_fnshd BIGNUMERIC(38,0),
cnt_bkg_chmbr_idle_tm BIGNUMERIC(38,0),
dwh_updated DATETIME NOT NULL
) CLUSTER BY dat_formdate, client_id;