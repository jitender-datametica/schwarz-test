CREATE TABLE IF NOT EXISTS  ldl_p_lew_mart_lead.v_org_all_store_merge
 AS
SELECT OSM.aspect_id,
 OSM.client_id,
 OSM.move_to_st_loc_sid AS move_to_store_id,
 OSM.move_store_desc,
 WH.src_wh_id AS wh_id,
 WH2.src_wh_id AS wh_id_exp,
 WH.loc_sid_wh,
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
 OSM.latitude,
 mdr.dat_modernization_from,
 mdr.dat_modernization_to
FROM ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act AS OSM
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON OSM.wh_loc_sid = WH.loc_sid_wh AND OSM.client_id = WH.client_id AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH2 ON OSM.wh_loc_sid_exp = WH2.loc_sid_wh AND OSM.client_id = WH2.client_id
     AND WH2.dwh_actual_fg = 1 /* CROSS JOIN below added to get the modernization dates */
 LEFT JOIN (SELECT BCP.client_id,
   LBH.loc_sid,
   BCP.act_closing_from_dt AS dat_modernization_from,
   BCP.act_closing_to_dt AS dat_modernization_to
  FROM ldl_p_lew_core_ac.v_building_closing_plan_hist AS BCP
   INNER JOIN ldl_p_lew_core_ac.v_location_building_hist AS LBH ON BCP.client_id = LBH.client_id AND BCP.building_sid =
     LBH.building_sid
  WHERE BCP.temporary_closing_reason_id = 1
   AND BCP.deleted_fg = 0
   AND LBH.deleted_fg = 0
   AND CURRENT_DATE BETWEEN BCP.dwh_valid_from AND BCP.dwh_valid_to
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(BCP.client_id AS STRING), CAST(LBH.loc_sid AS STRING) ORDER BY BCP.act_closing_to_dt
        IS NULL DESC, BCP.act_closing_to_dt DESC)) = 1) AS mdr ON OSM.client_id = mdr.client_id AND OSM.move_to_st_loc_sid
    = mdr.loc_sid /* analog MART_MSI */
WHERE OSM.client_id NOT IN (18)
 OR OSM.orig_store_nr <> 9988 AND NOT OSM.orig_store_nr BETWEEN 7501 AND 7599
UNION ALL
SELECT wawi_dummy.aspect_id,
 wawi_dummy.client_id,
 KEY_MAP.loc_sid AS move_to_store_id,
 wawi_dummy.move_store_desc,
 wawi_dummy.wh_id,
 wawi_dummy.wh_id_exp,
 wawi_dummy.loc_sid_wh,
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
 SUBSTR(CAST(wawi_dummy.street AS STRING), 1, 70) AS street,
 SUBSTR(CAST(wawi_dummy.zipcode AS STRING), 1, 15) AS zipcode,
 SUBSTR(CAST(wawi_dummy.city AS STRING), 1, 50) AS city,
 SUBSTR(CAST(wawi_dummy.phone AS STRING), 1, 50) AS phone,
 wawi_dummy.longitude,
 wawi_dummy.latitude,
 wawi_dummy.dat_modernization_from,
 wawi_dummy.dat_modernization_to
FROM (SELECT ASPT.aspect_id,
   CLNT.client_id,
    - 1 * CLNT.client_id AS move_to_store_id,
    '#' || TRIM(CNTR.country_iso_cd) AS move_store_desc,
    - 1 * CLNT.client_id AS wh_id,
    - 1 * CLNT.client_id AS wh_id_exp,
    - 1 * CLNT.client_id AS loc_sid_wh,
    - 1 * CLNT.client_id AS sales_manager_id,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_closing_ovis,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_opening_ovis,
   1 AS mis_store_active_fg,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_opening,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_closing,
    - 1 * CLNT.client_id AS orig_store_nr,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_calc_start_py,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_calc_end_py,
   NULL AS objectstatus_id,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_calc_start_ppy,
   0 AS move_fg,
   NULL AS street,
   NULL AS zipcode,
   NULL AS city,
   NULL AS phone,
   CAST(NULL AS BIGNUMERIC) AS longitude,
   CAST(NULL AS BIGNUMERIC) AS latitude,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_modernization_from,
   PARSE_DATE('%Y/%m/%d', NULL) AS dat_modernization_to
  FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS CLNT
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CNTR ON CLNT.country_id = CNTR.country_id
   INNER JOIN ldl_p_lew_mart_lead.v_ref_aspect AS ASPT ON TRUE
  WHERE CNTR.dashboard_relevant_fg = 1) AS wawi_dummy
 INNER JOIN ldl_p_lew_core_ac.v_loc_map_key AS KEY_MAP ON wawi_dummy.move_to_store_id = KEY_MAP.wawi_dwh_store_id;


