/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_store_item_advertise_day_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:43:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_store_item_advertise_day_1 (
ldl_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key of the item_1 in the Lidl DWH            LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM.ITEM_SID'),
ldl_store_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key of the store in the Lidl DWH            LDL: P_LEW_MART_LEAD_AC.V_ITM_ITEM.STORE_SID'),
adv_dt DATE NOT NULL
OPTIONS(description='Start date of the advertising campaign            LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM.ADV_PERIOD_START_DAY_DT'),
calc_adv_sales_begin_dt DATE NOT NULL
OPTIONS(description='Start date of the time range to link facts to the advertising campaign            LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM.REPORTING_ADV_PERIOD_START_DAY_DT'),
calc_adv_sales_end_dt DATE NOT NULL
OPTIONS(description='End date of the time range to link facts to the advertising campaign            LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM.REPORTING_ADV_PERIOD_END_DAY_DT'),
adv_period_overlap_fg BOOL
OPTIONS(description='Flag to mark advertise campaigns which overlap with other advertise campaign candidates from the advertise planning system if the full time range of 26 days is used for every advertise campaign            LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM.OVERLAP_PERIOD_FG'),
adv_period_shortened_fg BOOL
OPTIONS(description='Flag to mark advertise campaigns for which the legth of the fact linking time range has been shortened due to overlap with other advertise campaign candidates from the advertise planning system.            LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM.CUT_PERIOD_FG'),
ldl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key of the ERP client in the Lidl DWH            LDL: P_LEW_MART_PIT.CLIENT_ID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_sid, ldl_store_sid, adv_dt) NOT ENFORCED
)
OPTIONS(description='information about non food item_1 related advertise actions by store as provided by LDL PIT using APT based campaign elements             LDL: P_LEW_MART_PIT.T_F_PSNF_STORE_ADV_PERIOD_ITEM_1');