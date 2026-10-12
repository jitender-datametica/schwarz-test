CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wh_management_region_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
managing_board_int STRING(50) COLLATE 'und:ci' NOT NULL,
managing_director_sales STRING(50) COLLATE 'und:ci' NOT NULL,
managing_director_region STRING(50) COLLATE 'und:ci',
region_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);