CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_advertise_theme_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_ad_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key NFPO advertising theme            CBX: CNT_PROJECT.REF_NO'),
src_proj_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='NFPO ad theme reference            CBX: CNT_PROJECT.REF_NO'),
ad_theme_name STRING(100) OPTIONS(description='NFPO Theme name;            CBX: CNT_PROJECT.SHORT_DESC'),
ad_theme_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='NFPO Theme number (derived from advertising week): WW.N;            CBX: CNT_PROJECT.PROJECT_NO'),
ad_theme_id BIGNUMERIC(38,0)
OPTIONS(description='NFPO Theme ID (20-digit code);            CBX: CTM_PROJECT.CUST_TEXT5'),
busyear_ad_theme BIGNUMERIC(38,0)
OPTIONS(description='FK busyear: Financial year;            CBX: CNT_PROJECT.FINANCIAL_YEAR'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_ad_theme_sid) NOT ENFORCED
) OPTIONS(description='NFPO advertising themes             CBX: CNT_PROJECT');