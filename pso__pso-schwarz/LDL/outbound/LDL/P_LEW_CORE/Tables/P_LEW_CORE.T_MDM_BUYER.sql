CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_buyer (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
buyer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key to represent the NFPO source system user            CBX: CNT_USER.REF_NO'),
src_user_doc_ref STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='NFPO source system user reference            CBX: CNT_USER.REF_NO'),
cbx_user_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical version of the NFPO source system user            CBX: CNT_USER.VERSION'),
buyer_cd STRING(20)
OPTIONS(description='Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems            CBX: CNT_USER.SHORT_CODE'),
buyer_forename STRING(100) COLLATE 'und:ci'
OPTIONS(description='forename of the NFPO source system user            CBX: CNT_USER.FIRST_NAME'),
buyer_surname STRING(100) COLLATE 'und:ci'
OPTIONS(description='surname of the NFPO source system user            CBX: CNT_USER.LAST_NAME'),
buyer_email STRING(100) COLLATE 'und:ci'
OPTIONS(description='email of the NFPO source system user            CBX: CNT_USER.EMAIL'),
sso_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='sso_name of the NFPO source system user in the NFPO reporting UI            CBX: CNT_PROJECT.THEME_OWNER            '),
buyer_notes STRING(100) COLLATE 'und:ci'
OPTIONS(description='description or role comment of the NFPO source system user            CBX: CNT_USER.DESCRIPTION'),
buyer_manager_abbr_name STRING(100)
OPTIONS(description='coded name of the manager of the NFPO source system user            CBX: CTM_USER.CUST_TEXT2            '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (buyer_sid) NOT ENFORCED
) OPTIONS(description='NFPO user, mainly covering the role buyer             CBX: CNT_USER, CTM_USER');