CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_counting_status (
cnt_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='status of the counting of the item'),
cnt_status_descr STRING(100) OPTIONS(description='Description of the status of the counting performed'),
cnt_status_descr_en STRING(100) OPTIONS(description='Description in english of the status of the counting performed'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the last load when the data was inserted or updated'),
dwh_created DATETIME NOT NULL OPTIONS(description='Date of the record creation'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Date when the data was updated'),
PRIMARY KEY (cnt_status_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains known count flag status             Source: static T439_PART_INV_DET.C439_COUNTFLAG');