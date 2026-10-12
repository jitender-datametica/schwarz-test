/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_advertise_theme_hist
   generated from Powerdesigner on Dienstag, 15. August 2023 16:45:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_advertise_theme_hist (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical column required by the used ETL framework            static 7 for all rows.'),
mdm_ad_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ADVERTISING THEME.            CBX: CNT_PROJECT.REF_NO'),
cbx_proj_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical version of the NFPO adv theme in the source system.            CBX: CNT_PROJECT.VERSION'),
cbx_proj_doc_status STRING(100) COLLATE 'und:ci'
OPTIONS(description='Technical status of the NFPO adv theme in the source system (active, inactive, cancelled).            CBX: CNT_PROJECT.DOC_STATUS'),
cbx_proj_change_tmsp DATETIME NOT NULL
OPTIONS(description='Change timestamp of the NFPO theme in the source system.            CBX: CNT_PROJECT.UPDATED_ON'),
mdm_prev_ad_theme_sid BIGNUMERIC(38,0)
OPTIONS(description='Foreign Key NFPO ADVERTISING THEME for the advertising theme which is referenced as preceeding advertise theme that covered the same or a similar topic and same or similar items.            CBX: CTM_PROJECT.CUST_TEXT2'),
mdm_range_sel_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO RANGE SELECTION.            CBX: CNT_PROJECT.PROGRAM_REF'),
ad_theme_approval_status STRING(100) COLLATE 'und:ci'
OPTIONS(description='Adv theme approval status.            CBX: CNT_PROJECT.EDITING_STATUS'),
ad_theme_workflow_status STRING(100) COLLATE 'und:ci'
OPTIONS(description='NFPO adv theme workflow status.            CBX: CNT_PROJECT.STATUS (New --> New; customStatus01 --> Selection)'),
ad_theme_sell_from_day BIGNUMERIC(38,0)
OPTIONS(description='Day of the advertising week on which sales start. Usually there are 2 days in an advertising week where actions start, for example Monday and Thursday. This number indicates whether the first or the second is used for the theme.            CBX: CTM_PROJECT.CUST_CODELIST3'),
ad_theme_sell_from_dt DATE
OPTIONS(description='Date on which sales start, generally in the advertising week of this theme.            CBX: CTM_PROJECT.CUST_DATE1'),
ad_theme_resp_buyer_sid BIGNUMERIC(38,0)
OPTIONS(description='Responsible person for the advertising theme.            CBX: CNT_PROJECT.THEME_OWNER'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_ad_theme_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Historized attributes of NFPO advertising themes.             CBX: CNT_PROJECT, CTM_PROJECT');