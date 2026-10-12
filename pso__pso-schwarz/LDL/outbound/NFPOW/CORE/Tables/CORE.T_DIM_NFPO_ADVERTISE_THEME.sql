/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_advertise_theme
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_advertise_theme (
nfpo_adv_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ADVERTISING THEME.            CBX: CNT_PROJECT.REF_NO            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID'),
nfpo_adv_theme_nr STRING(100) NOT NULL
OPTIONS(description='NFPO adv theme reference.            CBX: CNT_PROJECT.REF_NO            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.SRC_PROJ_DOC_REF'),
nfpo_adv_theme_name STRING(100)
OPTIONS(description='NFPO adv theme name.            CBX: CNT_PROJECT.SHORT_DESC            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.AD_THEME_NAME'),
nfpo_adv_theme_week_cd STRING(100)
OPTIONS(description='NFPO adv theme number (derived from advertising week): WW.N;            CBX: CNT_PROJECT.PROJECT_NO            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.AD_THEME_CD'),
nfpo_adv_theme_status_cd STRING(100)
OPTIONS(description='Technical status of the NFPO adv theme in the source system (active, inactive, cancelled).            CBX: CNT_PROJECT.DOC_STATUS            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.CBX_PROJ_DOC_STATUS'),
nfpo_adv_theme_deliv_1_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Planned delivery weeks for NFPO advertising themes.            CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_DELIVER_HIST.CY_WEEK_THEME_DEL'),
nfpo_adv_theme_deliv_2_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Planned delivery weeks for NFPO advertising themes.            CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_DELIVER_HIST.CY_WEEK_THEME_DEL'),
nfpo_adv_theme_deliv_3_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Planned delivery weeks for NFPO advertising themes.            CBX: CTM_PROJECT.CUST_CODELIST1_NAME, CUST_CODELIST5_NAME, CUST_CODELIST6_NAME            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_DELIVER_HIST.CY_WEEK_THEME_DEL'),
nfpo_adv_theme_adv_1_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Planned advertising weeks for NFPO advertising themes.            CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST.CY_WEEK_THEME_ADV'),
nfpo_adv_theme_adv_2_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Planned advertising weeks for NFPO advertising themes.            CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST.CY_WEEK_THEME_ADV'),
nfpo_adv_theme_adv_3_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Planned advertising weeks for NFPO advertising themes.            CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST.CY_WEEK_THEME_ADV'),
nfpo_theme_resp_user_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Responsible person for the advertising theme.            CBX: CNT_PROJECT.THEME_OWNER            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_RESP_BUYER_SID'),
nfpo_theme_resp_user_acct_name STRING(100) NOT NULL
OPTIONS(description='NFPO source system user reference.            CBX: CNT_USER.REF_NO            LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF'),
nfpo_theme_resp_user_first_name STRING(100)
OPTIONS(description='Forename of the NFPO source system user.            CBX: CNT_USER.FIRST_NAME            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME'),
nfpo_theme_resp_user_last_name STRING(100)
OPTIONS(description='Surname of the NFPO source system user.            CBX: CNT_USER.LAST_NAME            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME'),
nfpo_theme_resp_user_abbr_name STRING(100)
OPTIONS(description='Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.            CBX: CNT_USER.SHORT_CODE            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD'),
nfpo_theme_resp_user_mgr_abbr_name STRING(100)
OPTIONS(description='Coded name of the manager of the NFPO source system user.            CBX: CTM_USER.CUST_TEXT2            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME'),
nfpo_ekl_user_abbr_name_list_txt STRING(1000) OPTIONS(description='konkatenierte Liste der EKL\'s der Artikel im Thema'),
nfpo_se_user_abbr_name_list_txt STRING(1000) OPTIONS(description='konkatenierte Liste der SE\'s der Artikel im Thema'),
nfpo_range_sel_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO RANGE SELECTION.            CBX: CNT_PROJECT.PROGRAM_REF            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.MDM_RANGE_SEL_SID'),
nfpo_range_sel_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the NFPO range selection.            CBX: CNT_PROGRAM.REF_NO            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.SRC_PROG_DOC_REF'),
nfpo_range_plan_nr STRING(100)
OPTIONS(description='Logical identifier of the NFPO range selection: sometimes technically 2 records for a logical range selection exist, but only one is active.            CBX: CNT_PROGRAM.PROGRAM_NO            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.RANGE_PLAN_CD'),
nfpo_range_sel_cal_month BIGNUMERIC(38,0)
OPTIONS(description='Range selection month.            CBX: CNT_PROGRAM.YEAR, PERIOD            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION'),
nfpo_range_sel_cal_year BIGNUMERIC(38,0),
nfpo_range_sel_deliv_from_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Range selection deliver-from calendar week.            CBX: CTM_PROGRAM.CUST_CODELIST1            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_FROM'),
nfpo_range_sel_deliv_to_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Range selection deliver-to calendar week.            CBX: CTM_PROGRAM.CUST_CODELIST2            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_TO'),
nfpo_range_sel_adv_from_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Range selection advertise-from calendar week.            CBX: CTM_PROGRAM.CUST_CODELIST3            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_FROM'),
nfpo_range_sel_adv_to_cal_week BIGNUMERIC(38,0)
OPTIONS(description='Range selection advertise-to calendar week.            CBX: CTM_PROGRAM.CUST_CODELIST4            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_TO'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_adv_theme_sid) NOT ENFORCED
) OPTIONS(description='NFPO advertising themes.');