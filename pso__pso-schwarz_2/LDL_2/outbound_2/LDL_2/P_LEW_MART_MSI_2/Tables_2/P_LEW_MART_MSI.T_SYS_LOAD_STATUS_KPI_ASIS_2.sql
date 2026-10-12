CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_sys_load_status_kpi_asis_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(3) COLLATE 'und:ci' NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_dayend DATE NOT NULL,
kpi_id BIGNUMERIC(38,0) NOT NULL,
data_deliv_fg BIGNUMERIC(38,0),
kpi_avbl_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
mod_tmsp DATETIME NOT NULL
);