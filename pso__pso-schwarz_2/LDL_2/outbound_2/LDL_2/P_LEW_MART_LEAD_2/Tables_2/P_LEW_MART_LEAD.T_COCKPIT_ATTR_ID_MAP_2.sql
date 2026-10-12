/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_cockpit_attr_id_map_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#  1.1    2026-01-16         Marcin Malec              AP0306173; adding columns threshold_dvj_absolute, threshold_dplan_absolute.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_cockpit_attr_id_map_2 (
identifier_hierarchy STRING(10) OPTIONS(description='KPI Hierarchy_2'),
identifier_id STRING(20) OPTIONS(description='KPI Id'),
identifier_flag NUMERIC(4) OPTIONS(description='KPI flag'),
identifier_flag_desc STRING(10) OPTIONS(description='KPI flag description'),
identifier_name STRING(100) OPTIONS(description='KPI Name'),
identifier_display_name STRING(100) OPTIONS(description='KPI displayed name'),
identifier_unit STRING(10) OPTIONS(description='KPI Unit_2'),
identifier_sorting_internal NUMERIC(4) OPTIONS(description='KPI Sorting internal'),
identifier_sorting_general NUMERIC(4) OPTIONS(description='KPI Sorting general'),
threshold_is STRING(10) OPTIONS(description='KPI Threshold IST'),
threshold_dplan STRING(10) OPTIONS(description='KPI Threshold dPlan'),
threshold_dvj STRING(10) OPTIONS(description='KPI Threshold dVJ'),
threshold_ber_st STRING(10) OPTIONS(description='KPI Threshold berSt'),
threshold_month STRING(10) OPTIONS(description='KPI Threshold month'),
threshold_aufgel STRING(10) OPTIONS(description='KPI Threshold aufgelaufen'),
threshold_dvj_absolute STRING(10) OPTIONS(description='KPI Threshold dVJ absolute'),
threshold_dplan_absolute STRING(10) OPTIONS(description='KPI Threshold dPlan absolute'),
process_name STRING(100) OPTIONS(description='Process Name'),
process_id NUMERIC(4) OPTIONS(description='Process Id'),
process_sorting NUMERIC(4) OPTIONS(description='Process Sorting'),
process_abbreviation STRING(10) OPTIONS(description='Process Short Form'),
leading_process_id NUMERIC(4) OPTIONS(description='Leading Process Id'),
leading_process_name STRING(100) OPTIONS(description='Leading Process Name'),
cockpit_flag_id STRING(30),
int_mgmt_1_1 NUMERIC(4),
int_ressort_ek_1_1_1 NUMERIC(4),
int_operativ_ek_1_1_1_1 NUMERIC(4),
int_ressort_vl_1_1_2 NUMERIC(4),
int_operativ_vt_1_1_2_2 NUMERIC(4),
int_operativ_vt_wg_1_1_2_1 NUMERIC(4),
int_operativ_log_1_1_4_1 NUMERIC(4),
dl_mgmt_1_2 NUMERIC(4),
dl_ressort_ek_1_2_1 NUMERIC(4),
dl_operativ_ek_1_2_1_1 NUMERIC(4),
dl_ressort_vl_1_2_2 NUMERIC(4),
dl_operativ_vt_1_2_2_2 NUMERIC(4),
dl_operativ_vt_wg_1_2_2_1 NUMERIC(4),
dl_operativ_log_1_2_4_1 NUMERIC(4),
ges_mgmt_1_3 NUMERIC(4),
ges_operativ_wg_1_3_2_1 NUMERIC(4),
ges_vt_1_3_2_2 NUMERIC(4),
ges_vl_1_3_2_3 NUMERIC(4),
ges_operativ_fil_1_3_2_4 NUMERIC(4),
ges_operativ_bt_1_3_4_1 NUMERIC(4)
) OPTIONS(description='Cockpit 2.0 attribures');