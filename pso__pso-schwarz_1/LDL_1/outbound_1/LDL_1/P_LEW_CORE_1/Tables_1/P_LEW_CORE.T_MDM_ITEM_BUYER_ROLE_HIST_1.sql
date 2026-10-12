CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_buyer_role_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key NFPO item_1 instance            CBX: CNT_ITEM.REF_NO'),
buyer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key to represent the NFPO source system user            CBX: CNT_ITEM.LDL_BUYER_REF, LDL_SE_REF, LDL_RESPONSIBLE_PERSON_REF, LDL_CONTRACT_APPROVAL_EMP_REF'),
role_type_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='type code of the role a NFPO user can be assigned to for a specific item_1 in the range selection process, derived from the source column            CBX: CNT_ITEM."EKL", "SE", "KVW", "KP"'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_item_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='relation between items and NFPO users in specific roles             CBX: CNT_ITEM_1');