/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for CNTL_CNTL_ETL_LOGGING structures.
#-------------------------------------------------------------------------------
# Description: DDLs for ETL Logging Control structures:
#                   FUNCTION f_QueryTag
#                   Sequence SEQ_CNTL_ETL_LOGGING
#                   TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ
#                   Logging Procedures
#                   View V_CNTL_ETL_LOGGING
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-27 Andreas Kurz    	Initial version
#  1.1  2021-08-16 Dirk Hering     	Fixes, formatting
#  1.2  2021-08-18 Andreas Kurz		Added Nr. of Processed Records
#									Changed the Procedures
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  2.5  2022-09-17 Andreas Kurz		Changed additional columns MULTI_CLIENT
#  2.6	2022-10-04 Nikolai Toknov	Change data type NUMBER(38,5)->INTEGER for columns START_DT_BASE_METRIC_NF_FA, END_DT_BASE_METRIC_NF_FA, START_DT_DELIV_QTY, END_DT_DELIV_QTY, START_DT_STC_REAL_QTY, END_DT_STC_REAL_QTY
#  2.7	2023-02-06 Nikolai Toknov	Change data type INTEGER -> NUMBER(38,5) (patch issue) for columns START_DT_BASE_METRIC_NF_FA, END_DT_BASE_METRIC_NF_FA, START_DT_DELIV_QTY, END_DT_DELIV_QTY, START_DT_STC_REAL_QTY, END_DT_STC_REAL_QTY
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MULTI_CLIENT_RUN_LST_NR
MULTI_CLIENT_RUN_LST_DESCR
MULTI_CLIENT_RUN_FG
*/

CREATE TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ (
	RUN_ID_SEQ								INTEGER				NOT NULL 	DEFAULT -1 										COMMENT 'Sequential NUMBER of ETL processing - based on SEQ_ETL_LOGGING',
	RUN_TS									TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Execution timestamp. Start of daily ETL processing',
	RUN_DAY_ID								DATE				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Execution DATE. Format YYYY-MM-DD',
	-- in case of parallel Execution Clusters of same application
	-- this will keep the clustering (partition by) key   
	RUN_CLUSTERING_DESC						VARCHAR				NOT NULL 	DEFAULT '[0]' 									COMMENT 'Execution cluster in case of parallel execution. Format [ Cluster name ]',
	-- Name of Application			
	APPLICATION_NAME						VARCHAR				NOT NULL 	DEFAULT 'N/A' 									COMMENT 'General name of the application. PITonCloud',
	
	-- executed client Id(s) -1 ::= All clients
	CLIENT_ID 								INTEGER		 		NOT NULL 	DEFAULT -1 										COMMENT 'Client ID e.g. 1=>AT',	

	-- executed client Id(s)
 	MULTI_CLIENT_RUN_LST					ARRAY																			COMMENT 'Executed Client ID(s) in case of multiple Client IDs will be executed',
	-- VC Populated by View						
	MOVING_RUN_ID_FROM_CURRENT				INTEGER		 					DEFAULT 0 										COMMENT '[View] Current ID = 0 previous Run IDs are -1,-2,etc.',

	-- params which were used during execution

	START_DT_PIT_DATA 						DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Start Date of pit data. First available Data Set',
	END_DT_PIT_DATA 						DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'End Date of pit data. Latest Data Point which was processed by PITonCloud',
	NEXT_RUN_DT_REAGG 						DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Next first possible run date of the reaggregation process. In case of Adv-Weekly ETL processing::Formula: [end_dt_pit_data]+8',
	CNT_DATA_HISTORY_PIT_IN_ADV_WEEKS 		INTEGER		 					DEFAULT 150 									COMMENT 'Number of Adv Weeks of the OVERall PITonCloud Data History. Calculated value based on current ETL-Processing.',
	CNT_DATA_HISTORY_PIT_IN_DAYS 			INTEGER		 					DEFAULT 1050									COMMENT 'Data history (moving time window) in number of days. Needed for housekeeping. E.g. 3 years of data history 3*365 = 1095 days',
	CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS 	INTEGER		 					DEFAULT 15 										COMMENT 'Number of Adv Weeks of the intermediate time period. Calculated value based on current ETL-Processing.',
	CNT_INTERMEDIATE_PERIOD_IN_DAYS 		INTEGER		 																	COMMENT 'Number of days of the intermediate time period (moving time window).E.g. 15 weeks of data history ::= 15*7 = 105 days',
	START_DT_INTERMEDIATE 					DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Start date of the re-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]*7',
	END_DT_INTERMEDIATE 					DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'End date of the re-aggregation process - dynamically calculated. Formula: ([START_DT_INTERMEDIATE]+6)+(([CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]+1)*7)',
	START_ADV_WEEK_INTERMEDIATE 			INTEGER		 																	COMMENT 'Start AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated',
	END_ADV_WEEK_INTERMEDIATE 				INTEGER		 																	COMMENT 'End AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated',
	CNT_REAGG_PERIOD_IN_ADV_WEEKS 			INTEGER		 					DEFAULT 9 										COMMENT 'Number of Adv.Weeks of the reagreggation process. E.g. 9 Weeks (alignment with LEAD aggregation framework)',
	CNT_REAGG_PERIOD_IN_DAYS 				INTEGER		 																	COMMENT 'Number of Days of the reaggregation process. Dynamically calulated. Formula and PITonCloud Daily/Weekly Processing. ',
	START_DT_REAGG 							DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'Start date of the re-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_REAGG_PERIOD_IN_ADV_WEEKS]*7',
	END_DT_REAGG 							DATE 				NOT NULL 	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') 	COMMENT 'End date of the re-aggregation process - dynamically calculated. Formula: ([start_dt_reagg]+6)+(([CNT_REAGG_PERIOD_IN_ADV_WEEKS]+1)*7)',
	START_ADV_WEEK_REAGG 					INTEGER		 																	COMMENT 'Start AdvWeek of reaggregation Process - Dynamically caluclated',
	END_ADV_WEEK_REAGG 						INTEGER		 																	COMMENT 'End AdvWeek of reaggregation Process - Dynamically caluclated',
	CNT_BASELINE_ADV_WEEK 					INTEGER		 					DEFAULT 6 										COMMENT 'Maximally allowed time gap AS number of Adv.Weeks for the baseline calculation',
	LOC_TIME_GAPS_OPENING_DAYS 				INTEGER		 					DEFAULT -13 									COMMENT 'Number of Day time Gap of Store Opening Days. Default - 13 days. Needed for Source View Location History.',
	LOC_TIME_GAPS_CLOSING_DAYS 				INTEGER		 					DEFAULT 13 										COMMENT 'Number of Day time Gap of Store Closing Days. Default + 13 days. Needed for Source View Location History.',
	WH_BUYING_PRICE_ADD_PERIOD_IN_DAYS 		INTEGER		 					DEFAULT 7 										COMMENT 'In case there could not be a buying price found within the defined time period range,',
	LOC_STORE_SALES_NET_VAL_GT 				NUMBER(38,5) 																	COMMENT 'Checking Rule for a Region Hierarchie Reject the Record if Sales Net Value is lower than the Parameter. Aggregation Level is Daily.',
	LOC_STORE_SALES_QTY_GT 					NUMBER(38,5) 																	COMMENT 'Checking Rule for a Region Hierarchie Reject the Record if Sales Quantity is lower than the Parameter. Aggregation Level is Daily.',
	ADP_TIME_GAP_IN_DAYS 					INTEGER		 																	COMMENT 'Maximally allowed time gap as number of days for APT Periods. In case of empty ADP periods (NULL) it will be set as ADP period start dt + @[apt_time_gap_in_days]. Used for Source View ADP Time gap in days Default +6 ',
	CTR_ADV_WEEK_START_WEEKDAY_ID 			INTEGER		 																	COMMENT 'Start Day of the Adv-Week of the Country. E.g. CH = 4. Based on ISO Calendar',
	CTR_STORE_NBR 							NUMBER(38,5) 																	COMMENT 'Approx. ~ nbr of stores of the country based on location history',
	CTR_EX_ELVIS_COUNTRY_FG 				SMALLINT	 					DEFAULT 0 										COMMENT 'Flag if a country is an Ex-Elvis Country. This is true (::=1) for <IR>,<AT>,<RS>',
	START_DT_BASE_METRIC_NF_FA 				NUMBER(38,5)			 														COMMENT 'Start Date into the past offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv - @[start_dt_base_metric_nf_fa]',
	END_DT_BASE_METRIC_NF_FA 				NUMBER(38,5)			 														COMMENT 'End Date into the future offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv + @[end_dt_base_metric_nf_fa]',
	START_DT_DELIV_QTY 						NUMBER(38,5)			 														COMMENT 'Start Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv - @[start_dt_deliv_qty]',
	END_DT_DELIV_QTY 						NUMBER(38,5)			 														COMMENT 'End Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv + @[end_dt_deliv_qty]',
	START_DT_STC_REAL_QTY 					NUMBER(38,5)			 														COMMENT 'Start Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv - @[start_dt_stc_qty]',
	END_DT_STC_REAL_QTY 					NUMBER(38,5)			 														COMMENT 'End Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv + @[end_dt_stc_qty]',
	EXEC_PIT_DAILY_RUN_FG 					SMALLINT	 																	COMMENT 'ABInitio Execution Parameter: Flag indication daily run of the entire PITonCloud ETL-Framework',
	EXEC_PIT_WEEKLY_RUN_FG 					SMALLINT	 																	COMMENT 'ABInitio Execution Parameter:  Flag indication daily run of the entire PITonCloud ETL-Framework',
	EXEC_PIT_DQ_RUN_FG 						SMALLINT	 																	COMMENT 'ABInitio Execution Parameter:  Flag indicating if the DQ-Framework should be executed',
	EXEC_PIT_MANUAL_RUN_FG 					SMALLINT	 																	COMMENT 'ABInitio Execution Parameter:  Flag / Indicator of the PITonCloud RunMode.  0::= running weekly at a specific weekday (running_weekly and current_date = execution day, 3::=running daily ; 1::= running only PIT countries which are in Param:  EXEC_PIT_MANUAL_COUNTRY_LST ; 2::= Initialize country run dedicyated inititlization process EXEC_PIT_CNT_INITIAL_ADV_WEEKS',
	EXEC_PIT_MANUAL_COUNTRY_LST 			VARCHAR	 																		COMMENT 'ABInitio Execution Parameter:  CSV List of countries which should be reprocessed only if PIT_MANUAL_RUN_FG = 2 - initialize data',
	EXEC_PIT_RUN_WEEKLY_WEEKDAY 			INTEGER		 																	COMMENT 'ABInitio Execution Parameter:  Flag indication weekly run on which day of week it should run',
	EXEC_PIT_CNT_INITIAL_ADV_WEEKS 			INTEGER		 																	COMMENT 'ABInitio Execution Parameter:  ',
	EXEC_PIT_AB_PARALLEL_EXECUTION 			INTEGER		 					DEFAULT 0 										COMMENT 'Abinitio Number of parallel executitions, default 0 --> running in sequence',
	EXEC_PIT_SF_CREDIT_TIMERANGE_IN_DAYS 	INTEGER		 					DEFAULT 7 										COMMENT 'SF Credit Consumption Reaggregation Window calculated based from Current Date backwards -1 * 7',
	DEFAULT_PIT_MANUAL_RUN_FG				SMALLINT	 					DEFAULT 3										COMMENT 'Default RunMode is Daily Run based on Parameter EXEC_PIT_RUN_WEEKLY_WEEKDAY',
	PIT_MAX_DATA_HISTORY_IN_DAYS 			INTEGER		 					DEFAULT 1050 									COMMENT 'Maximum Data History per Country in Days. E.g. 3 years of daily data. 150 Adv.Weeks * 7 = 1050. Needed for Houskeeping. ',
	PIT_MAX_DATA_HISTORY_IN_ADV_WEEK 		INTEGER		 					DEFAULT 150 									COMMENT 'Maximum Data History per Country in Days. E.g. 3 years 150 Adv.Weeks. Needed for Houskeeping.',
	EXEC_CLIENT_FG							SMALLINT	 					DEFAULT 0										COMMENT 'ABInitio Execution Parameter:  Flag / Indicator if the client should be run',
	
																														
	-- Technical fields				
	DELETED_FG								SMALLINT			NOT NULL 	DEFAULT 0 										COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS							TIMESTAMP			NOT NULL 	DEFAULT CURRENT_TIMESTAMP() 					COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS							TIMESTAMP		 																COMMENT 'Technical field timestamp when record was updated',
																															
	LOAD_ID									INTEGER				NOT NULL 	DEFAULT 0 										COMMENT 'Technical Field ELT / ABInitio Process ID',
	UNIQUE (RUN_ID_SEQ),
	PRIMARY KEY (RUN_ID_SEQ, RUN_TS)
)	COMMENT='ELT Control Table holding the sequence NUMBER. SF Workaround Holding the current RUN_SEQ_ID, which is unique per ELT-Daily (and/or Initial) processing. Important: the RUN_SEQ_ID is based on the sequence SEQ_ETL_LOGGING.'
;