/* #DescStart#
#$Revision: 6244 $, $LastChangedBy: hwieber $
#SubjectAreas#: Organisationsstruktur
#DescEnd# */
/* Adding country level dummy records for aspect id 1 and 2 */
CREATE OR REPLACE VIEW ldl_s_conl.v_org_account_manager_merge AS SELECT OAMM.aspect_id,
 OAMM.client_id,
 B.src_wh_id AS wh_id,
 OAMM.account_manager_id,
 OAMM.account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_org_account_manager_mrg_act AS OAMM
 INNER JOIN ldl_p_lew_core_ac.v_location AS B ON OAMM.client_id = B.client_id AND OAMM.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B' -- Filialen

WHERE OAMM.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping
   WHERE LOWER(user_name) = LOWER(SESSION_USER()))
UNION ALL
SELECT multiply.row_no AS aspect_id,
 CLNT.client_id,
  - 1 * CLNT.client_id AS wh_id,
  - 1 * CLNT.client_id AS account_manager_id,
  '#' || TRIM(CNTR.country_iso_cd) AS account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1
 AND CLNT.client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_org_all_store_merge_act", "p_lew_bil_ac.v_warehouse", "p_lew_bil_ac.v_store", "p_lew_core_ac.v_wawi_ref_client_country", "p_lew_core_ac.v_wawi_ref_country" ***/