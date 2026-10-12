CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ejr_ean_item_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
barcode INTEGER NOT NULL,
orig_item_nr INTEGER NOT NULL,
gtin_input_cd STRING(50) COLLATE 'und:ci' NOT NULL,
case_factor_ejr NUMERIC(7,3) NOT NULL,
load_id BIGNUMERIC(38,0),
valid_from_dat DATE
);