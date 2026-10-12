CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_mast_migrt_cntry (
client_id BIGNUMERIC(38,0) NOT NULL,
src_from_fg BIGNUMERIC(38,0) NOT NULL,
cntry_iso_cd STRING(3) NOT NULL,
country_id BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0),
ec_cd BIGNUMERIC(38,0) NOT NULL,
src_valid_from_dat DATE NOT NULL,
src_valid_to_dat DATE NOT NULL
);