CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_advertise_theme_deliver_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_ad_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key NFPO advertising theme            CBX: CNT_PROJECT.REF_NO'),
item_del_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='sequence of advertising weeks derived from source column name'),
cy_week_theme_del BIGNUMERIC(38,0)
OPTIONS(description='planned delivery weeks for NFPO advertising themes            CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_ad_theme_sid, item_del_seq, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='planned delivery weeks for NFPO advertising themes             CBX: CTM_PROJECT');