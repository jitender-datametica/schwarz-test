/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_cockpit_attr_id_map
#----------------------------------------------------------------------------
# History:
#  1.0    2023-10-13         Marcin Malec              Initial version.
#  1.1    2026-01-16         Marcin Malec              AP0306173; adding columns threshold_dvj_absolute, threshold_dplan_absolute.
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.t_cockpit_attr_id_map (
  identifier_hierarchy VARCHAR(10)                      COMMENT 'KPI Hierarchy'                  ,
  identifier_id VARCHAR(20)                             COMMENT 'KPI Id'                         ,
  identifier_flag NUMBER(4)                             COMMENT 'KPI flag'                       ,
  identifier_flag_desc VARCHAR(10)                      COMMENT 'KPI flag description'           ,
  identifier_name VARCHAR(100)                          COMMENT 'KPI Name'                       ,
  identifier_display_name VARCHAR(100)                  COMMENT 'KPI displayed name'             ,
  identifier_unit VARCHAR(10)                           COMMENT 'KPI Unit'                       ,
  identifier_sorting_internal NUMBER(4)                 COMMENT 'KPI Sorting internal'           ,
  identifier_sorting_general NUMBER(4)                  COMMENT 'KPI Sorting general'            ,
  threshold_is VARCHAR(10)                              COMMENT 'KPI Threshold IST'              ,
  threshold_dplan VARCHAR(10)                           COMMENT 'KPI Threshold dPlan'            ,
  threshold_dvj VARCHAR(10)                             COMMENT 'KPI Threshold dVJ'              ,
  threshold_ber_st VARCHAR(10)                          COMMENT 'KPI Threshold berSt'            ,
  threshold_month VARCHAR(10)                           COMMENT 'KPI Threshold month'            ,
  threshold_aufgel VARCHAR(10)                          COMMENT 'KPI Threshold aufgelaufen'      ,
  threshold_dvj_absolute VARCHAR(10)                    COMMENT 'KPI Threshold dVJ absolute'     ,
  threshold_dplan_absolute VARCHAR(10)                  COMMENT 'KPI Threshold dPlan absolute'   ,
  process_name VARCHAR(100)                             COMMENT 'Process Name'                   ,
  process_id NUMBER(4)                                  COMMENT 'Process Id'                     ,
  process_sorting NUMBER(4)                             COMMENT 'Process Sorting'                ,
  process_abbreviation VARCHAR(10)                      COMMENT 'Process Short Form'             ,
  leading_process_id NUMBER(4)                          COMMENT 'Leading Process Id'             ,
  leading_process_name VARCHAR(100)                     COMMENT 'Leading Process Name'           ,
  cockpit_flag_id VARCHAR(30)                                                                    ,
  int_mgmt_1_1 NUMBER(4)                                                                         ,
  int_ressort_ek_1_1_1 NUMBER(4)                                                                 ,
  int_operativ_ek_1_1_1_1 NUMBER(4)                                                              ,
  int_ressort_vl_1_1_2 NUMBER(4)                                                                 ,
  int_operativ_vt_1_1_2_2 NUMBER(4)                                                              ,
  int_operativ_vt_wg_1_1_2_1 NUMBER(4)                                                           ,
  int_operativ_log_1_1_4_1 NUMBER(4)                                                             ,
  dl_mgmt_1_2 NUMBER(4)                                                                          ,
  dl_ressort_ek_1_2_1 NUMBER(4)                                                                  ,
  dl_operativ_ek_1_2_1_1 NUMBER(4)                                                               ,
  dl_ressort_vl_1_2_2 NUMBER(4)                                                                  ,
  dl_operativ_vt_1_2_2_2 NUMBER(4)                                                               ,
  dl_operativ_vt_wg_1_2_2_1 NUMBER(4)                                                            ,
  dl_operativ_log_1_2_4_1 NUMBER(4)                                                              ,
  ges_mgmt_1_3 NUMBER(4)                                                                         ,
  ges_operativ_wg_1_3_2_1 NUMBER(4)                                                              ,
  ges_vt_1_3_2_2 NUMBER(4)                                                                       ,
  ges_vl_1_3_2_3 NUMBER(4)                                                                       ,
  ges_operativ_fil_1_3_2_4 NUMBER(4)                                                             ,
  ges_operativ_bt_1_3_4_1 NUMBER(4)
) COMMENT = 'Cockpit 2.0 attribures'
;
