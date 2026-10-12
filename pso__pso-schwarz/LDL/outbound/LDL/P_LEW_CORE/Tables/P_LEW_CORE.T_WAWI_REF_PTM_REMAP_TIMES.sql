CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_ptm_remap_times (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0),
workingtype_id STRING(4) COLLATE 'und:ci' NOT NULL,
source_ptm_table STRING(128) COLLATE 'und:ci' NOT NULL,
target_ptm_table STRING(128) COLLATE 'und:ci' NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);