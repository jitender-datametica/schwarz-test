CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_ORG_ALL_STORE_MERGE
(
  aspect_id
 ,client_id
 ,move_to_store_id
 ,move_store_desc
 ,wh_id
 ,wh_id_exp
 ,loc_sid_wh
 ,sales_manager_id
 ,dat_closing_ovis
 ,dat_opening_ovis
 ,mis_store_active_fg
 ,dat_opening
 ,dat_closing
 ,orig_store_nr
 ,dat_calc_start_py
 ,dat_calc_end_py
 ,objectstatus_id
 ,dat_calc_start_ppy
 ,move_fg
 ,street
 ,zipcode
 ,city
 ,phone
 ,longitude
 ,latitude
 ,dat_modernization_from
 ,dat_modernization_to
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT
  osm.aspect_id
 ,osm.client_id
 ,osm.move_to_st_loc_sid AS move_to_store_id
 ,osm.move_store_desc
 ,wh.src_wh_id           AS wh_id
 ,wh2.src_wh_id          AS wh_id_exp
 ,wh.loc_sid_wh          AS loc_sid_wh
 ,osm.sales_manager_id
 ,osm.dat_closing_ovis
 ,osm.dat_opening_ovis
 ,osm.mis_store_active_fg
 ,osm.dat_opening
 ,osm.dat_closing
 ,osm.orig_store_nr
 ,osm.dat_calc_start_py
 ,osm.dat_calc_end_py
 ,osm.objectstatus_id
 ,osm.dat_calc_start_ppy
 ,osm.move_fg
 ,osm.street
 ,osm.zipcode
 ,osm.city
 ,osm.phone
 ,osm.longitude
 ,osm.latitude
 ,mdr.dat_modernization_from
 ,mdr.dat_modernization_to
FROM p_lew_core_ac.v_wawi_org_all_store_merge_act AS osm
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON osm.wh_loc_sid = wh.loc_sid_wh
AND osm.client_id = wh.client_id
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_bil_ac.v_warehouse AS wh2
ON osm.wh_loc_sid_exp = wh2.loc_sid_wh
AND osm.client_id = wh2.client_id
AND wh2.dwh_actual_fg = 1
/* Join below added to get the modernization dates */
LEFT OUTER JOIN
(
  SELECT
    bcp.client_id
   ,lbh.loc_sid
   ,bcp.act_closing_from_dt AS dat_modernization_from
   ,bcp.act_closing_to_dt   AS dat_modernization_to
  FROM p_lew_core_ac.v_building_closing_plan_hist AS bcp
  INNER JOIN p_lew_core_ac.v_location_building_hist AS lbh
  ON bcp.client_id = lbh.client_id
  AND bcp.building_sid = lbh.building_sid
  WHERE temporary_closing_reason_id = 1
  AND bcp.deleted_fg = 0
  AND lbh.deleted_fg = 0
 AND CURRENT_DATE BETWEEN bcp.dwh_valid_from AND bcp.dwh_valid_to
  QUALIFY ROW_NUMBER() OVER(PARTITION BY bcp.client_id, lbh.loc_sid ORDER BY bcp.act_closing_to_dt DESC) = 1
) AS mdr
ON osm.client_id = mdr.client_id
AND osm.move_to_st_loc_sid = mdr.loc_sid
/* analog MART_MSI */
WHERE NOT(osm.client_id IN (18) AND (osm.orig_store_nr BETWEEN 7501 AND 7599 OR osm.orig_store_nr=9988))
   
UNION ALL
/* Dummy store added at country level for aspect 1, 2*/
SELECT
  wawi_dummy.aspect_id
 ,wawi_dummy.client_id
 ,key_map.loc_sid                    AS move_to_store_id
 ,wawi_dummy.move_store_desc
 ,wawi_dummy.wh_id
 ,wawi_dummy.wh_id_exp
 ,wawi_dummy.loc_sid_wh
 ,wawi_dummy.sales_manager_id
 ,wawi_dummy.dat_closing_ovis
 ,wawi_dummy.dat_opening_ovis
 ,wawi_dummy.mis_store_active_fg
 ,wawi_dummy.dat_opening
 ,wawi_dummy.dat_closing
 ,wawi_dummy.orig_store_nr
 ,wawi_dummy.dat_calc_start_py
 ,wawi_dummy.dat_calc_end_py
 ,wawi_dummy.objectstatus_id
 ,wawi_dummy.dat_calc_start_ppy
 ,wawi_dummy.move_fg
 ,wawi_dummy.street
 ,wawi_dummy.zipcode
 ,wawi_dummy.city
 ,wawi_dummy.phone
 ,wawi_dummy.longitude
 ,wawi_dummy.latitude
 ,wawi_dummy.dat_modernization_from
 ,wawi_dummy.dat_modernization_to
FROM
(
  SELECT
    aspt.aspect_id                   AS aspect_id
   ,clnt.client_id                   AS client_id
   ,-1 * clnt.client_id              AS move_to_store_id
   ,'#'|| TRIM( cntr.country_iso_cd) AS move_store_desc
   ,-1 * clnt.client_id              AS wh_id
   ,-1 * clnt.client_id              AS wh_id_exp
   ,-1 * clnt.client_id              AS loc_sid_wh
   ,-1 * clnt.client_id              AS sales_manager_id
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_closing_ovis
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_opening_ovis
   ,1                                AS mis_store_active_fg
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_opening
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_closing
   ,-1 * clnt.client_id              AS orig_store_nr
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_calc_start_py
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_calc_end_py
   ,NULL                             AS objectstatus_id
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_calc_start_ppy
   ,0                                AS move_fg
   ,NULL                             AS street
   ,NULL                             AS zipcode
   ,NULL                             AS city
   ,NULL                             AS phone
   ,TO_NUMBER(NULL)                  AS longitude
   ,TO_NUMBER(NULL)                  AS latitude
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_modernization_from
   ,TO_DATE(NULL, 'YYYY/MM/DD')      AS dat_modernization_to
  FROM p_lew_core_ac.v_wawi_ref_client_country AS clnt
  INNER JOIN p_lew_core_ac.v_wawi_ref_country AS cntr
  ON clnt.country_id = cntr.country_id
  CROSS JOIN p_lew_mart_lead.v_ref_aspect AS aspt
  WHERE cntr.dashboard_relevant_fg = 1
) wawi_dummy
INNER JOIN p_lew_core_ac.v_loc_map_key key_map
ON wawi_dummy.move_to_store_id=key_map.wawi_dwh_store_id
;
