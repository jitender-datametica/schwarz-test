/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for view P_LEW_MART_LEAD_AC.v_cockpit_attr_id_map_2
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#  1.1    2026-01-16         Marcin Malec              AP0306173; adding columns threshold_dvj_absolute, threshold_dplan_absolute.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cockpit_attr_id_map_2 (identifier_hierarchy, identifier_id,
identifier_flag, identifier_flag_desc, identifier_name, identifier_display_name, identifier_unit,
identifier_sorting_internal, identifier_sorting_general, threshold_is, threshold_dplan, threshold_dvj, threshold_ber_st
, threshold_month, threshold_aufgel, threshold_dvj_absolute, threshold_dplan_absolute, process_name, process_id,
process_sorting, process_abbreviation, leading_process_id, leading_process_name, cockpit_flag_id, int_mgmt_1_1,
int_ressort_ek_1_1_1, int_operativ_ek_1_1_1_1, int_ressort_vl_1_1_2, int_operativ_vt_1_1_2_2, int_operativ_vt_wg_1_1_2_1
, int_operativ_log_1_1_4_1, dl_mgmt_1_2, dl_ressort_ek_1_2_1, dl_operativ_ek_1_2_1_1, dl_ressort_vl_1_2_2,
dl_operativ_vt_1_2_2_2, dl_operativ_vt_wg_1_2_2_1, dl_operativ_log_1_2_4_1, ges_mgmt_1_3, ges_operativ_wg_1_3_2_1,
ges_vt_1_3_2_2, ges_vl_1_3_2_3, ges_operativ_fil_1_3_2_4, ges_operativ_bt_1_3_4_1) AS SELECT identifier_hierarchy,
 identifier_id,
 identifier_flag,
 identifier_flag_desc,
 identifier_name,
 identifier_display_name,
 identifier_unit,
 identifier_sorting_internal,
 identifier_sorting_general,
 threshold_is,
 threshold_dplan,
 threshold_dvj,
 threshold_ber_st,
 threshold_month,
 threshold_aufgel,
 threshold_dvj_absolute,
 threshold_dplan_absolute,
 process_name,
 process_id,
 process_sorting,
 process_abbreviation,
 leading_process_id,
 leading_process_name,
 cockpit_flag_id,
 int_mgmt_1_1,
 int_ressort_ek_1_1_1,
 int_operativ_ek_1_1_1_1,
 int_ressort_vl_1_1_2,
 int_operativ_vt_1_1_2_2,
 int_operativ_vt_wg_1_1_2_1,
 int_operativ_log_1_1_4_1,
 dl_mgmt_1_2,
 dl_ressort_ek_1_2_1,
 dl_operativ_ek_1_2_1_1,
 dl_ressort_vl_1_2_2,
 dl_operativ_vt_1_2_2_2,
 dl_operativ_vt_wg_1_2_2_1,
 dl_operativ_log_1_2_4_1,
 ges_mgmt_1_3,
 ges_operativ_wg_1_3_2_1,
 ges_vt_1_3_2_2,
 ges_vl_1_3_2_3,
 ges_operativ_fil_1_3_2_4,
 ges_operativ_bt_1_3_4_1
FROM ldl_p_lew_mart_lead.t_cockpit_attr_id_map_2;