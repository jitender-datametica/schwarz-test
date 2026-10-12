CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_gl_region_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
gl_region_id BIGNUMERIC(38,0) NOT NULL,
gl_region_desc STRING(60) COLLATE 'und:ci',
gl_last_name STRING(30) COLLATE 'und:ci',
gl_first_name STRING(30) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);