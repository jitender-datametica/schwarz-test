/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_PROCESSING_PARAM_NORMALIZED
#-------------------------------------------------------------------------------
# Description: Create DDL for Control Table - Lookup PIT processing params
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-02-10 Andreas Kurz     Initial version, Remodelled
#  1.1  2022-03-02 Andreas Kurz		Small Changes on Param Name CNT_MAX_DATA_HISTORY_PIT_IN_DAYS
#  1.2	2022-09-29 Nikolai Toknov	Change data type NUMBER(38,5)->INTEGER for columns START_DT_BASE_METRIC_NF_FA, END_DT_BASE_METRIC_NF_FA, START_DT_DELIV_QTY, END_DT_DELIV_QTY, START_DT_STC_REAL_QTY, END_DT_STC_REAL_QTY
#  1.3  2024-01-19 Andreas Kurz		
#-------------------------------------------------------------------------------
*/


/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_PROCESSING_PARAM_NORMALIZED
------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_NORMALIZED CLUSTER BY (CLIENT_ID)(
	CLIENT_ID 								INTEGER		 	NOT NULL 	DEFAULT -1 										COMMENT 'Client ID e.g. 1=>AT',
	START_DT_PIT_DATA 						DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Start Date of pit data. First available Data Set',
	END_DT_PIT_DATA 						DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'End Date of pit data. Latest Data Point which was processed by PITonCloud',
	NEXT_RUN_DT_REAGG 						DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Next first possible run date of the reaggregation process. In case of Adv-Weekly ETL processing::Formula: [end_dt_pit_data]+8',
	CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS 		INTEGER		 				DEFAULT 150 									COMMENT 'Number of Adv Weeks of the OVERall PITonCloud Data History. Calculated value based on current ETL-Processing.',
	CNT_DATA_HISTORY_PIT_IN_DAYS 			INTEGER		 				DEFAULT 1050									COMMENT 'Data history (moving time window) in number of days. Needed for housekeeping. E.g. 3 years of data history 3*365 = 1095 days',
	CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS 	INTEGER		 				DEFAULT 15 										COMMENT 'Number of Adv Weeks of the intermediate time period. Calculated value based on current ETL-Processing.',
	CNT_INTERMEDIATE_PERIOD_IN_DAYS 		INTEGER		 																COMMENT 'Number of days of the intermediate time period (moving time window).E.g. 15 weeks of data history ::= 15*7 = 105 days',
	START_DT_INTERMEDIATE 					DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Start date of the re-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]*7',
	END_DT_INTERMEDIATE 					DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'End date of the re-aggregation process - dynamically calculated. Formula: ([START_DT_INTERMEDIATE]+6)+(([CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]+1)*7)',
	START_ADV_WEEK_INTERMEDIATE 			INTEGER		 																COMMENT 'Start AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated',
	END_ADV_WEEK_INTERMEDIATE 				INTEGER		 																COMMENT 'End AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated',
	CNT_REAGG_PERIOD_IN_ADV_WEEKS 			INTEGER		 				DEFAULT 9 										COMMENT 'Number of Adv.Weeks of the reagreggation process. E.g. 9 Weeks (alignment with LEAD aggregation framework)',
	CNT_REAGG_PERIOD_IN_DAYS 				INTEGER		 																COMMENT 'Number of Days of the reaggregation process. Dynamically calulated. Formula and PITonCloud Daily/Weekly Processing. ',
	START_DT_REAGG 							DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Start date of the re-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_REAGG_PERIOD_IN_ADV_WEEKS]*7',
	END_DT_REAGG 							DATE 			NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'End date of the re-aggregation process - dynamically calculated. Formula: ([start_dt_reagg]+6)+(([CNT_REAGG_PERIOD_IN_ADV_WEEKS]+1)*7)',
	START_ADV_WEEK_REAGG 					INTEGER		 																COMMENT 'Start AdvWeek of reaggregation Process - Dynamically caluclated',
	END_ADV_WEEK_REAGG 						INTEGER		 																COMMENT 'End AdvWeek of reaggregation Process - Dynamically caluclated',
	CNT_BASELINE_ADV_WEEK 					INTEGER		 				DEFAULT 6 										COMMENT 'Maximally allowed time gap AS number of Adv.Weeks for the baseline calculation',
	LOC_TIME_GAPS_OPENING_DAYS 				INTEGER		 				DEFAULT -13 									COMMENT 'Number of Day time Gap of Store Opening Days. Default - 13 days. Needed for Source View Location History.',
	LOC_TIME_GAPS_CLOSING_DAYS 				INTEGER		 				DEFAULT 13 										COMMENT 'Number of Day time Gap of Store Closing Days. Default + 13 days. Needed for Source View Location History.',
	WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS 		INTEGER		 				DEFAULT 7 										COMMENT 'In case there could not be a buying price found within the defined time period range,',
	LOC_STORE_SALES_NET_VAL_GT 				NUMBER(38,5) 																COMMENT 'Checking Rule for a Region Hierarchie Reject the Record if Sales Net Value is lower than the Parameter. Aggregation Level is Daily.',
	LOC_STORE_SALES_QTY_GT 					NUMBER(38,5) 																COMMENT 'Checking Rule for a Region Hierarchie Reject the Record if Sales Quantity is lower than the Parameter. Aggregation Level is Daily.',
	ADP_TIME_GAP_IN_DAYS 					INTEGER		 																COMMENT 'Maximally allowed time gap as number of days for APT Periods. In case of empty ADP periods (NULL) it will be set as ADP period start dt + @[apt_time_gap_in_days]. Used for Source View ADP Time gap in days Default +6 ',
	CTR_ADV_WEEK_START_WEEKDAY_ID 			INTEGER		 																COMMENT 'Start Day of the Adv-Week of the Country. E.g. CH = 4. Based on ISO Calendar',
	CTR_STORE_NBR 							NUMBER(38,5) 																COMMENT 'Approx. ~ nbr of stores of the country based on location history',
	CTR_EX_ELVIS_COUNTRY_FG 				SMALLINT	 				DEFAULT 0 										COMMENT 'Flag if a country is an Ex-Elvis Country. This is true (::=1) for <IR>,<AT>,<RS>',
	START_DT_BASE_METRIC_NF_FA 				INTEGER		 																COMMENT 'Start Date into the past offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv - @[start_dt_base_metric_nf_fa]',
	END_DT_BASE_METRIC_NF_FA 				INTEGER		 																COMMENT 'End Date into the future offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv + @[end_dt_base_metric_nf_fa]',
	START_DT_DELIV_QTY 						INTEGER	 																	COMMENT 'Start Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv - @[start_dt_deliv_qty]',
	END_DT_DELIV_QTY 						INTEGER 																	COMMENT 'End Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv + @[end_dt_deliv_qty]',
	START_DT_STC_REAL_QTY 					INTEGER 																	COMMENT 'Start Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv - @[start_dt_stc_qty]',
	END_DT_STC_REAL_QTY 					INTEGER 																	COMMENT 'End Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv + @[end_dt_stc_qty]',
	EXEC_PIT_DAILY_RUN_FG 					SMALLINT	 																COMMENT 'ABInitio Execution Parameter: Flag indication daily run of the entire PITonCloud ETL-Framework',
	EXEC_PIT_WEEKLY_RUN_FG 					SMALLINT	 																COMMENT 'ABInitio Execution Parameter:  Flag indication daily run of the entire PITonCloud ETL-Framework',
	EXEC_PIT_DQ_RUN_FG 						SMALLINT	 																COMMENT 'ABInitio Execution Parameter:  Flag indicating if the DQ-Framework should be executed',
	EXEC_PIT_MANUAL_RUN_FG 					SMALLINT	 																COMMENT 'ABInitio Execution Parameter:  Flag / Indicator of the PITonCloud RunMode.  0::= running weekly at a specific weekday (running_weekly and current_date = execution day, 3::=running daily ; 1::= running only PIT countries which are in Param:  EXEC_PIT_MANUAL_COUNTRY_LST ; 2::= Initialize country run dedicyated inititlization process EXEC_PIT_CNT_INITIAL_ADV_WEEKS',
	EXEC_PIT_MANUAL_COUNTRY_LST 			VARCHAR	 																	COMMENT 'ABInitio Execution Parameter:  CSV List of countries which should be reprocessed only if PIT_MANUAL_RUN_FG = 2 - initialize data',
	EXEC_PIT_RUN_WEEKLY_WEEKDAY 			INTEGER		 																COMMENT 'ABInitio Execution Parameter:  Flag indication weekly run on which day of week it should run',
	EXEC_PIT_CNT_INITIAL_ADV_WEEKS 			INTEGER		 																COMMENT 'ABInitio Execution Parameter:  ',
	EXEC_PIT_AB_PARALLEL_EXECUTION 			INTEGER		 				DEFAULT 0 										COMMENT 'Abinitio Number of parallel executitions, default 0 --> running in sequence',
	EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS 	INTEGER		 				DEFAULT 7 										COMMENT 'SF Credit Consumption Reaggregation Window calculated based from Current Date backwards -1 * 7',
	DEFAULT_PIT_MANUAL_RUN_FG				SMALLINT	 				DEFAULT 3										COMMENT 'Default RunMode is Daily Run based on Parameter EXEC_PIT_RUN_WEEKLY_WEEKDAY',
	PIT_MAX_DATA_HISTORY_IN_DAYS 			INTEGER		 				DEFAULT 1050 									COMMENT 'Maximum Data History per Country in Days. E.g. 3 years of daily data. 150 Adv.Weeks * 7 = 1050. Needed for Houskeeping. ',
	PIT_MAX_DATA_HISTORY_IN_ADV_WEEK 		INTEGER		 				DEFAULT 150 									COMMENT 'Maximum Data History per Country in Days. E.g. 3 years 150 Adv.Weeks. Needed for Houskeeping.',
	
	WAWI_PRICE_CHANGE_GAP_IN_DAYS			INTEGER		 				DEFAULT 4										COMMENT 'WaWi-PV Period Gap in Days (Default is 4 Days)',
	PV_PERIOD_LENGTH_MAX					INTEGER		 				DEFAULT 62										COMMENT 'WaWi-PV Period maximal Length (Default is 62 Days)',
	PV_PERIOD_GAP_SPLITTING_DAYS			INTEGER		 				DEFAULT 6										COMMENT 'WaWi-PV Period splitting long period internal technical parameter (Default is 6 Days).',
	LP_ORIG_COUPON_TYPE_SID					VARCHAR						DEFAULT 'IN (3,4,5,6,7,8,12)'					COMMENT 'LP-PV original coupon Type SID. Default is IN (3,4,5,6,7,8,12).',
	LP_COUPON_PROMO_TYPE_SID				VARCHAR						DEFAULT 'IN (7,12,13)'							COMMENT 'LP-PV promotion type sid internal technical parameter. Default is IN (7,12,13).',
	FA_OVERLAP_PERIOD_ACTION_TYPE_CONDITION	VARCHAR						DEFAULT 'IN (2,3)'								COMMENT 'WaWi-PV and FA/NF Overlapp conditions. Default: IN (2,3).',
	REJECT_PERIOD							VARCHAR						DEFAULT 'PV'									COMMENT 'WaWi-PV and FA/NF Overlapp result. Default: PV.',
	LP_SHIFT_PERIOD_START_DT				INTEGER						DEFAULT 0 										COMMENT 'LP-PV shift start period by a number of days. DE (23) = +1',
	REJECT_WAWI_PV_LONG_PERIOD				SMALLINT					DEFAULT 0 										COMMENT 'WaWi-PV Long Period will be rejected 1::= Reject set REJECT_REASON_CODE ::=6000',

	PRIMARY KEY (CLIENT_ID)
)COMMENT='Automatically Genrerated Control Table - one row represents the all prameters for the PIT country. Lookup PIT processing params'
;