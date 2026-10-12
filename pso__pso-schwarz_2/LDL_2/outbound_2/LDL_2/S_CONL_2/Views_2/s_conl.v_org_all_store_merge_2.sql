/* #DescStart#
#$Revision: 9128 $, $LastChangedBy: aarnold $
#SubjectAreas#: Organisationsstruktur
#DescEnd# */
/* Dummy_2 store added at country_2 level for aspect 1, 2 */ CREATE OR REPLACE VIEW ldl_s_conl.v_org_all_store_merge_2 AS
SELECT OSM.aspect_id,
 OSM.client_id,
 OSM.move_to_st_loc_sid AS move_to_store_id,
 OSM.move_store_desc,
 WH.src_wh_id AS wh_id,
 WH2.src_wh_id AS wh_id_exp,
 OSM.sales_manager_id,
 OSM.dat_closing_ovis,
 OSM.dat_opening_ovis,
 OSM.mis_store_active_fg,
 OSM.dat_opening,
 OSM.dat_closing,
 OSM.orig_store_nr,
 OSM.dat_calc_start_py,
 OSM.dat_calc_end_py,
 OSM.objectstatus_id,
 OSM.dat_calc_start_ppy,
 OSM.move_fg,
 OSM.street,
 OSM.zipcode,
 OSM.city,
 OSM.phone,
 OSM.longitude,
 OSM.latitude
FROM ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS OSM
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON OSM.wh_loc_sid = WH.loc_sid_wh AND OSM.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH2 ON OSM.wh_loc_sid_exp = WH2.loc_sid_wh AND OSM.client_id = WH2.client_id
     AND WH2.dwh_actual_fg = 1
WHERE OSM.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()))
UNION ALL
SELECT wawi_dummy.aspect_id,
 wawi_dummy.client_id,
 ST.loc_sid_store AS move_to_store_id,
 wawi_dummy.move_store_desc,
 wawi_dummy.wh_id,
 wawi_dummy.wh_id_exp,
 wawi_dummy.sales_manager_id,
 wawi_dummy.dat_closing_ovis,
 wawi_dummy.dat_opening_ovis,
 wawi_dummy.mis_store_active_fg,
 wawi_dummy.dat_opening,
 wawi_dummy.dat_closing,
 wawi_dummy.orig_store_nr,
 wawi_dummy.dat_calc_start_py,
 wawi_dummy.dat_calc_end_py,
 CAST(wawi_dummy.objectstatus_id AS BIGNUMERIC) AS objectstatus_id,
 wawi_dummy.dat_calc_start_ppy,
 wawi_dummy.move_fg,
 wawi_dummy.street,
 wawi_dummy.zipcode,
 wawi_dummy.city,
 wawi_dummy.phone,
 wawi_dummy.longitude,
 wawi_dummy.latitude
FROM (SELECT multiply.row_no AS aspect_id,
   CLNT.client_id,
    - 1 * CLNT.client_id AS move_to_store_id,
    '#' || TRIM(CNTR.country_iso_cd) AS move_store_desc,
    - 1 * CLNT.client_id AS wh_id,
    - 1 * CLNT.client_id AS wh_id_exp,
    - 1 * CLNT.client_id AS sales_manager_id,
   DATE(NULL) AS dat_closing_ovis,
   DATE(NULL) AS dat_opening_ovis,
   1 AS mis_store_active_fg,
   DATE(NULL) AS dat_opening,
   DATE(NULL) AS dat_closing,
    - 1 * CLNT.client_id AS orig_store_nr,
   DATE(NULL) AS dat_calc_start_py,
   DATE(NULL) AS dat_calc_end_py,
   NULL AS objectstatus_id,
   DATE(NULL) AS dat_calc_start_ppy,
   0 AS move_fg,
   CAST(NULL AS STRING) AS street,
   CAST(NULL AS STRING) AS zipcode,
   CAST(NULL AS STRING) AS city,
   CAST(NULL AS STRING) AS phone,
   CAST(NULL AS NUMERIC) AS longitude,
   CAST(NULL AS NUMERIC) AS latitude
  FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLNT
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS CNTR ON CLNT.country_id = CNTR.country_id
   INNER JOIN (SELECT 1 AS row_no
     UNION ALL
     SELECT 2 AS row_no) AS multiply ON TRUE
  WHERE CNTR.dashboard_relevant_fg = 1) AS wawi_dummy
 INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS ST ON wawi_dummy.client_id = ST.client_id AND wawi_dummy.move_to_store_id = ST.src_store_id
     AND ST.dwh_actual_fg = 1
WHERE wawi_dummy.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_sales_manager_merge_act_2", "p_lew_core_ac.v_location_2", "p_lew_core_ac.v_wawi_ref_client_country_2", "p_lew_core_ac.v_wawi_ref_country_2" ***/