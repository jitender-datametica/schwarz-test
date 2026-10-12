CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_season_stores_1 (iso_cd, aspect_id, wh_id, wh_desc, store_id, store_desc) AS
SELECT str.iso_cd,
 str.aspect_id,
 str.wh_id,
 WHM.wh_desc,
 str.store_id,
 str.store_desc
FROM (SELECT CLI.country_cd AS iso_cd,
    STR.aspect_id,
    STW.orig_wh_nr AS wh_id,
    STR.src_orig_store_nr AS store_id,
    STR.store_desc,
    STW.loc_sid_wh
   FROM ldl_p_lew_bil_ac.v_org_store_merge_1 AS STR
    INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_1 AS STW ON STR.loc_sid_store_move_to = STW.loc_sid_store AND
      CURRENT_DATE BETWEEN STW.dwh_valid_from AND STW.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON STR.client_id = CLI.client_id
   WHERE STR.aspect_id = 1
   UNION ALL
   SELECT CLI.country_cd AS iso_cd,
    STR.aspect_id,
    WH.src_wh_id AS wh_id,
    STR.src_orig_store_nr AS store_id,
    STR.store_desc,
    STR.loc_sid_wh
   FROM ldl_p_lew_bil_ac.v_org_store_merge_1 AS STR
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON STR.loc_sid_wh = WH.loc_sid_wh AND CURRENT_DATE BETWEEN WH.dwh_valid_from
      AND WH.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON STR.client_id = CLI.client_id
   WHERE STR.aspect_id = 2) AS str
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_merge_act_1 AS WHM ON str.loc_sid_wh = WHM.wh_loc_sid AND str.aspect_id = WHM
   .aspect_id;