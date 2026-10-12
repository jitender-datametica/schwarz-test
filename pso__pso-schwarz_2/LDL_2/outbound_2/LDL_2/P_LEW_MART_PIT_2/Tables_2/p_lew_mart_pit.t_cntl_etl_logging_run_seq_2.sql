/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDLs for CNTL_CNTL_ETL_LOGGING structures.
#-------------------------------------------------------------------------------
# Description: DDLs for ETL Logging Control structures:
#                   FUNCTION f_QueryTag
#                   Sequence SEQ_CNTL_ETL_LOGGING
#                   TABLE P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_RUN_SEQ_2
#                   Logging Procedures
#                   View V_CNTL_ETL_LOGGING_2
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


-- VC Populated by View
 -- params which were used during execution

-- in case of parallel Execution Clusters of same application
 -- this will keep the clustering (partition by) key

-- executed client Id(s)
 -- Name of Application
 -- Technical fields
 -- executed client Id(s) -1 ::= All clients

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_etl_logging_run_seq_2 (
run_id_seq INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Sequential NUMBER of ETL processing - based on SEQ_ETL_LOGGING'),
run_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Execution timestamp. Start of daily ETL processing'),
run_day_id DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Execution DATE. Format YYYY-MM_2-DD'),
run_clustering_desc STRING(16777216) DEFAULT '[0]' NOT NULL
OPTIONS(description='Execution cluster in case of parallel execution. Format [ Cluster name ]'),
application_name STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='General name of the application. PITonCloud'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
multi_client_run_lst ARRAY < STRING >OPTIONS(description='Executed Client ID(s) in case of multiple Client IDs will be executed'),
moving_run_id_from_current INTEGER DEFAULT 0
OPTIONS(description='[View] Current ID = 0 previous Run IDs are -1,-2,etc.'),
start_dt_pit_data DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start Date of pit data. First available Data Set'),
end_dt_pit_data DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End Date of pit data. Latest Data Point which was processed by PITonCloud'),
next_run_dt_reagg DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Next first possible run date of the reaggregation process. In case of Adv-Weekly ETL processing::Formula: [end_dt_pit_data]+8'),
cnt_data_history_pit_in_adv_weeks INTEGER DEFAULT 150
OPTIONS(description='Number of Adv Weeks of the OVERall PITonCloud Data History. Calculated value based on current ETL-Processing.'),
cnt_data_history_pit_in_days INTEGER DEFAULT 1050
OPTIONS(description='Data history (moving time window) in number of days. Needed for housekeeping. E.g. 3 years of data history 3*365 = 1095 days'),
cnt_intermediate_period_in_adv_weeks INTEGER DEFAULT 15
OPTIONS(description='Number of Adv Weeks of the intermediate time period. Calculated value based on current ETL-Processing.'),
cnt_intermediate_period_in_days INTEGER
OPTIONS(description='Number of days of the intermediate time period (moving time window).E.g. 15 weeks of data history ::= 15*7 = 105 days'),
start_dt_intermediate DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start date of the re_2-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]*7'),
end_dt_intermediate DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End date of the re_2-aggregation process - dynamically calculated. Formula: ([START_DT_INTERMEDIATE]+6)+(([CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]+1)*7)'),
start_adv_week_intermediate INTEGER
OPTIONS(description='Start AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated'),
end_adv_week_intermediate INTEGER
OPTIONS(description='End AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated'),
cnt_reagg_period_in_adv_weeks INTEGER DEFAULT 9
OPTIONS(description='Number of Adv.Weeks of the reagreggation process. E.g. 9 Weeks (alignment with LEAD aggregation framework)'),
cnt_reagg_period_in_days INTEGER
OPTIONS(description='Number of Days of the reaggregation process. Dynamically calulated. Formula and PITonCloud Daily/Weekly Processing. '),
start_dt_reagg DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start date of the re_2-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_REAGG_PERIOD_IN_ADV_WEEKS]*7'),
end_dt_reagg DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End date of the re_2-aggregation process - dynamically calculated. Formula: ([start_dt_reagg]+6)+(([CNT_REAGG_PERIOD_IN_ADV_WEEKS]+1)*7)'),
start_adv_week_reagg INTEGER OPTIONS(description='Start AdvWeek of reaggregation Process - Dynamically caluclated'),
end_adv_week_reagg INTEGER OPTIONS(description='End AdvWeek of reaggregation Process - Dynamically caluclated'),
cnt_baseline_adv_week INTEGER DEFAULT 6
OPTIONS(description='Maximally allowed time gap AS number of Adv.Weeks for the baseline calculation'),
loc_time_gaps_opening_days INTEGER DEFAULT - 13
OPTIONS(description='Number of Day time Gap of Store Opening Days. Default - 13 days. Needed for Source View Location_2 History.'),
loc_time_gaps_closing_days INTEGER DEFAULT 13
OPTIONS(description='Number of Day time Gap of Store Closing Days. Default + 13 days. Needed for Source View Location_2 History.'),
wh_buying_price_add_period_in_days INTEGER DEFAULT 7
OPTIONS(description='In case there could not be a buying price found within the defined time period range,'),
loc_store_sales_net_val_gt BIGNUMERIC(38,5)
OPTIONS(description='Checking Rule for a Region_2 Hierarchie Reject the Record if Sales_2 Net Value is lower than the Parameter. Aggregation Level is Daily.'),
loc_store_sales_qty_gt BIGNUMERIC(38,5)
OPTIONS(description='Checking Rule for a Region_2 Hierarchie Reject the Record if Sales_2 Quantity is lower than the Parameter. Aggregation Level is Daily.'),
adp_time_gap_in_days INTEGER
OPTIONS(description='Maximally allowed time gap as number of days for APT Periods. In case of empty ADP periods (NULL) it will be set as ADP period start dt + @[apt_time_gap_in_days]. Used for Source View ADP Time gap in days Default +6 '),
ctr_adv_week_start_weekday_id INTEGER
OPTIONS(description='Start Day of the Adv-Week of the Country. E.g. CH = 4. Based on ISO Calendar_2'),
ctr_store_nbr BIGNUMERIC(38,5) OPTIONS(description='Approx. ~ nbr of stores of the country_2 based on location_2 history'),
ctr_ex_elvis_country_fg INTEGER DEFAULT 0
OPTIONS(description='Flag if a country_2 is an Ex-Elvis Country. This is true (::=1) for <IR>,<AT>,<RS_2>'),
start_dt_base_metric_nf_fa BIGNUMERIC(38,5)
OPTIONS(description='Start Date into the past offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv - @[start_dt_base_metric_nf_fa]'),
end_dt_base_metric_nf_fa BIGNUMERIC(38,5)
OPTIONS(description='End Date into the future offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv + @[end_dt_base_metric_nf_fa]'),
start_dt_deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='Start Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv - @[start_dt_deliv_qty]'),
end_dt_deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='End Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv + @[end_dt_deliv_qty]'),
start_dt_stc_real_qty BIGNUMERIC(38,5)
OPTIONS(description='Start Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv - @[start_dt_stc_qty]'),
end_dt_stc_real_qty BIGNUMERIC(38,5)
OPTIONS(description='End Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv + @[end_dt_stc_qty]'),
exec_pit_daily_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter: Flag indication daily run of the entire PITonCloud ETL-Framework'),
exec_pit_weekly_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag indication daily run of the entire PITonCloud ETL-Framework'),
exec_pit_dq_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag indicating if the DQ-Framework should be executed'),
exec_pit_manual_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag / Indicator of the PITonCloud RunMode.  0::= running weekly at a specific weekday (running_weekly and current_date = execution day, 3::=running daily ; 1::= running only PIT countries which are in Param:  EXEC_PIT_MANUAL_COUNTRY_LST ; 2::= Initialize country_2 run dedicyated inititlization process EXEC_PIT_CNT_INITIAL_ADV_WEEKS'),
exec_pit_manual_country_lst STRING(16777216)
OPTIONS(description='ABInitio Execution Parameter:  CSV List of countries which should be reprocessed only if PIT_MANUAL_RUN_FG = 2 - initialize data'),
exec_pit_run_weekly_weekday INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag indication weekly run on which day of week it should run'),
exec_pit_cnt_initial_adv_weeks INTEGER OPTIONS(description='ABInitio Execution Parameter:  '),
exec_pit_ab_parallel_execution INTEGER DEFAULT 0
OPTIONS(description='Abinitio Number of parallel executitions, default 0 --> running in sequence'),
exec_pit_sf_credit_timerange_in_days INTEGER DEFAULT 7
OPTIONS(description='SF Credit Consumption Reaggregation Window calculated based from Current Date backwards -1 * 7'),
default_pit_manual_run_fg INTEGER DEFAULT 3
OPTIONS(description='Default RunMode is Daily Run based on Parameter EXEC_PIT_RUN_WEEKLY_WEEKDAY'),
pit_max_data_history_in_days INTEGER DEFAULT 1050
OPTIONS(description='Maximum Data History per Country_2 in Days. E.g. 3 years of daily data. 150 Adv.Weeks * 7 = 1050. Needed for Houskeeping. '),
pit_max_data_history_in_adv_week INTEGER DEFAULT 150
OPTIONS(description='Maximum Data History per Country_2 in Days. E.g. 3 years 150 Adv.Weeks. Needed for Houskeeping.'),
exec_client_fg INTEGER DEFAULT 0
OPTIONS(description='ABInitio Execution Parameter:  Flag / Indicator if the client should be run'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (run_id_seq, run_ts) NOT ENFORCED
)
OPTIONS(description='ELT Control Table holding the sequence NUMBER. SF Workaround Holding the current RUN_SEQ_ID, which is unique per ELT-Daily (and/or Initial) processing. Important: the RUN_SEQ_ID is based on the sequence SEQ_ETL_LOGGING.');