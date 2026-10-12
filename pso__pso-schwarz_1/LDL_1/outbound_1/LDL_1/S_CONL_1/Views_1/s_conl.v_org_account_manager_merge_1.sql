/* #DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd# */
/* Adding country_1 level dummy_1 records for aspect id 1 and 2 */
CREATE OR REPLACE VIEW ldl_s_conl.v_org_account_manager_merge_1 AS SELECT OAMM.aspect_id,
 OAMM.client_id,
 B.src_wh_id AS wh_id,
 OAMM.account_manager_id,
 OAMM.account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_org_account_manager_mrg_act_1 AS OAMM
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B ON OAMM.client_id = B.client_id AND OAMM.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' -- Filialen

WHERE OAMM.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()))
UNION ALL
SELECT multiply.row_no AS aspect_id,
 CLNT.client_id,
  - 1 * CLNT.client_id AS wh_id,
  - 1 * CLNT.client_id AS account_manager_id,
  '#' || TRIM(CNTR.country_iso_cd) AS account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_1 AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1
 AND CLNT.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_all_store_merge_act_1", "p_lew_bil_ac.v_warehouse_1", "p_lew_bil_ac.v_store_1", "p_lew_core_ac.v_wawi_ref_client_country_1", "p_lew_core_ac.v_wawi_ref_country_1" ***/