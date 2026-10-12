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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_processing_param_normalized (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
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
OPTIONS(description='Start date of the re-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]*7'),
end_dt_intermediate DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End date of the re-aggregation process - dynamically calculated. Formula: ([START_DT_INTERMEDIATE]+6)+(([CNT_INTERMEDIATE_PERIOD_IN_ADV_WEEKS]+1)*7)'),
start_adv_week_intermediate INTEGER
OPTIONS(description='Start AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated'),
end_adv_week_intermediate INTEGER
OPTIONS(description='End AdvWeek of intermediate Fact ETL  Process - Dynamically caluclated'),
cnt_reagg_period_in_adv_weeks INTEGER DEFAULT 9
OPTIONS(description='Number of Adv.Weeks of the reagreggation process. E.g. 9 Weeks (alignment with LEAD aggregation framework)'),
cnt_reagg_period_in_days INTEGER
OPTIONS(description='Number of Days of the reaggregation process. Dynamically calulated. Formula and PITonCloud Daily/Weekly Processing. '),
start_dt_reagg DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start date of the re-aggregation process - dynamically calculated. Formula: ([end_dt_pit_data]-6)-[CNT_REAGG_PERIOD_IN_ADV_WEEKS]*7'),
end_dt_reagg DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End date of the re-aggregation process - dynamically calculated. Formula: ([start_dt_reagg]+6)+(([CNT_REAGG_PERIOD_IN_ADV_WEEKS]+1)*7)'),
start_adv_week_reagg INTEGER OPTIONS(description='Start AdvWeek of reaggregation Process - Dynamically caluclated'),
end_adv_week_reagg INTEGER OPTIONS(description='End AdvWeek of reaggregation Process - Dynamically caluclated'),
cnt_baseline_adv_week INTEGER DEFAULT 6
OPTIONS(description='Maximally allowed time gap AS number of Adv.Weeks for the baseline calculation'),
loc_time_gaps_opening_days INTEGER DEFAULT - 13
OPTIONS(description='Number of Day time Gap of Store Opening Days. Default - 13 days. Needed for Source View Location History.'),
loc_time_gaps_closing_days INTEGER DEFAULT 13
OPTIONS(description='Number of Day time Gap of Store Closing Days. Default + 13 days. Needed for Source View Location History.'),
wh_buying_price_add_period_in_days INTEGER DEFAULT 7
OPTIONS(description='In case there could not be a buying price found within the defined time period range,'),
loc_store_sales_net_val_gt BIGNUMERIC(38,5)
OPTIONS(description='Checking Rule for a Region Hierarchie Reject the Record if Sales Net Value is lower than the Parameter. Aggregation Level is Daily.'),
loc_store_sales_qty_gt BIGNUMERIC(38,5)
OPTIONS(description='Checking Rule for a Region Hierarchie Reject the Record if Sales Quantity is lower than the Parameter. Aggregation Level is Daily.'),
adp_time_gap_in_days INTEGER
OPTIONS(description='Maximally allowed time gap as number of days for APT Periods. In case of empty ADP periods (NULL) it will be set as ADP period start dt + @[apt_time_gap_in_days]. Used for Source View ADP Time gap in days Default +6 '),
ctr_adv_week_start_weekday_id INTEGER
OPTIONS(description='Start Day of the Adv-Week of the Country. E.g. CH = 4. Based on ISO Calendar'),
ctr_store_nbr BIGNUMERIC(38,5) OPTIONS(description='Approx. ~ nbr of stores of the country based on location history'),
ctr_ex_elvis_country_fg INTEGER DEFAULT 0
OPTIONS(description='Flag if a country is an Ex-Elvis Country. This is true (::=1) for <IR>,<AT>,<RS>'),
start_dt_base_metric_nf_fa INTEGER
OPTIONS(description='Start Date into the past offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv - @[start_dt_base_metric_nf_fa]'),
end_dt_base_metric_nf_fa INTEGER
OPTIONS(description='End Date into the future offset for calulating NF/FA base metrics (sales_net_val, sales_qty, receipts_cnt). Logic: dat_adv + @[end_dt_base_metric_nf_fa]'),
start_dt_deliv_qty INTEGER
OPTIONS(description='Start Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv - @[start_dt_deliv_qty]'),
end_dt_deliv_qty INTEGER
OPTIONS(description='End Date into the past offset for calulating NF/FA Delivery quantity . Logic: dat_adv + @[end_dt_deliv_qty]'),
start_dt_stc_real_qty INTEGER
OPTIONS(description='Start Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv - @[start_dt_stc_qty]'),
end_dt_stc_real_qty INTEGER
OPTIONS(description='End Date into the past offset for calulating NF/FA Stock quantity . Logic: dat_adv + @[end_dt_stc_qty]'),
exec_pit_daily_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter: Flag indication daily run of the entire PITonCloud ETL-Framework'),
exec_pit_weekly_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag indication daily run of the entire PITonCloud ETL-Framework'),
exec_pit_dq_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag indicating if the DQ-Framework should be executed'),
exec_pit_manual_run_fg INTEGER
OPTIONS(description='ABInitio Execution Parameter:  Flag / Indicator of the PITonCloud RunMode.  0::= running weekly at a specific weekday (running_weekly and current_date = execution day, 3::=running daily ; 1::= running only PIT countries which are in Param:  EXEC_PIT_MANUAL_COUNTRY_LST ; 2::= Initialize country run dedicyated inititlization process EXEC_PIT_CNT_INITIAL_ADV_WEEKS'),
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
OPTIONS(description='Maximum Data History per Country in Days. E.g. 3 years of daily data. 150 Adv.Weeks * 7 = 1050. Needed for Houskeeping. '),
pit_max_data_history_in_adv_week INTEGER DEFAULT 150
OPTIONS(description='Maximum Data History per Country in Days. E.g. 3 years 150 Adv.Weeks. Needed for Houskeeping.'),
wawi_price_change_gap_in_days INTEGER DEFAULT 4 OPTIONS(description='WaWi-PV Period Gap in Days (Default is 4 Days)'),
pv_period_length_max INTEGER DEFAULT 62 OPTIONS(description='WaWi-PV Period maximal Length (Default is 62 Days)'),
pv_period_gap_splitting_days INTEGER DEFAULT 6
OPTIONS(description='WaWi-PV Period splitting long period internal technical parameter (Default is 6 Days).'),
lp_orig_coupon_type_sid STRING(16777216) DEFAULT 'IN (3,4,5,6,7,8,12)'
OPTIONS(description='LP-PV original coupon Type SID. Default is IN (3,4,5,6,7,8,12).'),
lp_coupon_promo_type_sid STRING(16777216) DEFAULT 'IN (7,12,13)'
OPTIONS(description='LP-PV promotion type sid internal technical parameter. Default is IN (7,12,13).'),
fa_overlap_period_action_type_condition STRING(16777216) DEFAULT 'IN (2,3)'
OPTIONS(description='WaWi-PV and FA/NF Overlapp conditions. Default: IN (2,3).'),
reject_period STRING(16777216) DEFAULT 'PV' OPTIONS(description='WaWi-PV and FA/NF Overlapp result. Default: PV.'),
lp_shift_period_start_dt INTEGER DEFAULT 0
OPTIONS(description='LP-PV shift start period by a number of days. DE (23) = +1'),
reject_wawi_pv_long_period INTEGER DEFAULT 0
OPTIONS(description='WaWi-PV Long Period will be rejected 1::= Reject set REJECT_REASON_CODE ::=6000'),
PRIMARY KEY (client_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Automatically Genrerated Control Table - one row represents the all prameters for the PIT country. Lookup PIT processing params');