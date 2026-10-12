CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_file_content_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
file_id BIGNUMERIC(38,0) NOT NULL,
region_sid BIGNUMERIC(38,0) NOT NULL,
period_sid BIGNUMERIC(38,0) NOT NULL,
src_assort_parent_cat_cd STRING(800) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);