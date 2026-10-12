CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat0_org_account_manager_merge_2 AS SELECT OAMM.aspect_id,
 OAMM.client_id,
 B.src_wh_id AS wh_id,
 OAMM.account_manager_id,
 OAMM.account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_org_account_manager_mrg_act_2 AS OAMM
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS B ON OAMM.client_id = B.client_id AND OAMM.wh_loc_sid = B.loc_sid AND B.wh_store_mark
    = 'B'
UNION ALL
SELECT multiply.row_no AS aspect_id,
 CLNT.client_id,
  - 1 * CLNT.client_id AS wh_id,
  - 1 * CLNT.client_id AS account_manager_id,
  '#' || TRIM(CNTR.country_iso_cd) AS account_manager_name
FROM ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLNT
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_2 AS CNTR ON CLNT.country_id = CNTR.country_id
 INNER JOIN (SELECT 1 AS row_no
   UNION ALL
   SELECT 2 AS row_no) AS multiply ON TRUE
WHERE CNTR.dashboard_relevant_fg = 1;