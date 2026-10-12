CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ref_hier_start_group_1 (
perspective_id BIGNUMERIC(38,0) NOT NULL,
start_group_id BIGNUMERIC(38,0) NOT NULL,
start_group_desc STRING(50) COLLATE 'und:ci' NOT NULL,
start_group_long_desc STRING(100) COLLATE 'und:ci' NOT NULL,
start_group_ipadimage STRING(255) COLLATE 'und:ci',
start_group_webimage STRING(255) COLLATE 'und:ci',
start_group_weblink STRING(255) COLLATE 'und:ci',
start_group_mobilelink STRING(255) COLLATE 'und:ci',
my_cockpit_weblink STRING(255) COLLATE 'und:ci',
my_cockpit_mobilelink STRING(255) COLLATE 'und:ci',
document_type_fg BIGNUMERIC(38,0),
document_type_fg_desc STRING(50) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);