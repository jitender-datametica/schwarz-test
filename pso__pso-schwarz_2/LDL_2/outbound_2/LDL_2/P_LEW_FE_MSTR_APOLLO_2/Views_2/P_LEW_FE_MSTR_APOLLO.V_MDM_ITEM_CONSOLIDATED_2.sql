CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_consolidated_2 (client_id, mdm_item_sid, src_item_doc_ref,
mdm_item_name, item_ian, adv_range_plan_cd, range_plan_cd, item_selection_nr, step_item_nr, konstrukt_multipack,
cbx_item_version_nr, cbx_item_doc_status, cbx_item_change_tmsp, market_sid, item_fam_grp_sid, brand_sid,
country_pol_sid_origin, mdm_sup_sid, ean_ownership_cd, sup_final_fg, item_workflow_status_id, item_class_cd,
buy_status_cd, display_type_cd, hier_node_sid, item_collection, item_notes, guarantee_cd, guarantee_type_cd,
guarantee_art, item_quality_class_cd, main_pillar_cd, mdm_pillar_sid, mdm_pillar_name, kfl_brand_sid, innovation_fg,
season_name, catalog_fg, cancel_reason_name, initial_range_plan_cd, selection_purch_net_euro_price,
min_target_sales_gross_euro_price, plan_purch_net_euro_price, final_purch_net_euro_price, initial_purch_net_euro_price,
deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT I.client_id,
 I.mdm_item_sid,
 I.src_item_doc_ref,
 I.mdm_item_name,
 I.item_ian,
 RS.range_plan_cd AS adv_range_plan_cd,
 I.range_plan_cd,
 I.item_selection_nr,
 I.step_item_nr,
 iset.max_set_multipack_fg AS konstrukt_multipack,
 IH.cbx_item_version_nr,
 IH.cbx_item_doc_status,
 IH.cbx_item_change_tmsp,
 IH.market_sid,
 IH.item_fam_grp_sid,
 IH.brand_sid,
 IH.country_pol_sid_origin,
 IH.mdm_sup_sid,
 IH.ean_ownership_cd,
 IH.sup_final_fg,
 IH.item_workflow_status_id,
 IH.item_class_cd,
 IH.buy_status_cd,
 IH.display_type_cd,
 IH.hier_node_sid,
 IH.item_collection,
 IH.item_notes,
 IH.guarantee_cd,
 IH.guarantee_type_cd,
 IH.guarantee_art,
 IH.item_quality_class_cd,
 IH.main_pillar_cd,
 COALESCE(IH.mdm_pillar_sid, -1) AS mdm_pillar_sid,
 COALESCE(MP.mdm_pillar_name, 'UNDEFINED') AS mdm_pillar_name,
 IH.kfl_brand_sid,
 IH.innovation_fg,
 IH.season_name,
 IH.catalog_fg,
 IH.cancel_reason_name,
 IH.initial_range_plan_cd,
 ipp.selection_purch_net_euro_price,
 ipp.min_target_sales_gross_euro_price,
 ipp.plan_purch_net_euro_price,
 ipp.final_purch_net_euro_price,
 ipp.initial_purch_net_euro_price,
 IH.deleted_fg,
 IH.dwh_valid_from,
 IH.dwh_valid_to,
 IH.dwh_load_id,
 IH.dwh_created,
 IH.dwh_updated
FROM ldl_p_lew_fe_mstr_apollo.v_mdm_item_2 AS I
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_item_hist_2 AS IH ON I.mdm_item_sid = IH.mdm_item_sid AND CURRENT_DATE BETWEEN
    IH.dwh_valid_from AND IH.dwh_valid_to AND IH.deleted_fg = 0
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_item_familygroup_2 AS FG ON IH.item_fam_grp_sid = FG.item_fam_grp_sid
 LEFT JOIN ldl_p_lew_fe_mstr_apollo.v_ref_mdm_pillar_2 AS MP ON IH.mdm_pillar_sid = MP.mdm_pillar_sid
 LEFT JOIN (SELECT mdm_item_sid,
   MAX(set_multipack_fg) AS max_set_multipack_fg,
   COUNT(DISTINCT set_multipack_fg) AS dist_set_multipack_fg
  FROM ldl_p_lew_fe_mstr_apollo.v_mdm_item_set_2
  GROUP BY mdm_item_sid) AS iset ON I.mdm_item_sid = iset.mdm_item_sid
 LEFT JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_ad_theme_item_hist_2 AS ATIH ON I.mdm_item_sid = ATIH.mdm_item_sid AND
    CURRENT_DATE BETWEEN ATIH.dwh_valid_from AND ATIH.dwh_valid_to AND ATIH.deleted_fg = 0
 LEFT JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_advertise_theme_hist_2 AS ATH ON ATIH.mdm_ad_theme_sid = ATH.mdm_ad_theme_sid
   AND CURRENT_DATE BETWEEN ATH.dwh_valid_from AND ATH.dwh_valid_to AND ATH.deleted_fg = 0
 LEFT JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_range_selection_2 AS RS_2 ON ATH.mdm_range_sel_sid = RS.mdm_range_sel_sid
 LEFT JOIN (SELECT mdm_item_sid,
   selection_purch_net_euro_price,
   min_target_sales_gross_euro_price,
   plan_purch_net_euro_price,
   final_purch_net_euro_price,
   initial_purch_net_euro_price
  FROM (SELECT IPH.mdm_item_sid,
     ips.price_scenario_name,
     IPH.item_price
    FROM (SELECT PS.mdm_price_scenario_nr,
        CASE
        WHEN PT.mdm_price_type_name = 'EK-Preis AM'
        THEN 'selection_purch_net_euro_price'
        WHEN PT.mdm_price_type_name = 'Zielverkaufspreis'
        THEN 'min_target_sales_gross_euro_price'
        WHEN PT.mdm_price_type_name = 'WBP Plan' AND PS.lob_cd = 'LDL' AND PS.market_sid = 3
        THEN 'plan_purch_net_euro_price'
        WHEN PT.mdm_price_type_name = 'Abschlusspreis' AND PS.lob_cd = 'LDL' AND PS.market_sid = 3 AND PS.incoterm_cd =
          'DDP'
        THEN 'final_purch_net_euro_price'
        WHEN PT.mdm_price_type_name = 'Abschlusspreis' AND PS.lob_cd = 'LDL' AND PS.market_sid = 3 AND PS.incoterm_cd =
          'FOB'
        THEN 'initial_purch_net_euro_price'
        ELSE NULL
        END AS price_scenario_name
      FROM ldl_p_lew_core.t_mdm_price_scenario_2 AS PS
       INNER JOIN ldl_p_lew_core.t_mdm_price_type_2 AS PT ON PS.mdm_price_type_cd = PT.mdm_price_type_cd
      WHERE PT.mdm_price_type_name = 'EK-Preis AM'
       OR PT.mdm_price_type_name = 'Zielverkaufspreis'
       OR PT.mdm_price_type_name = 'WBP Plan' AND PS.lob_cd = 'LDL' AND PS.market_sid = 3
       OR PT.mdm_price_type_name = 'Abschlusspreis' AND PS.lob_cd = 'LDL' AND PS.market_sid = 3 AND PS.incoterm_cd =
         'DDP'
       OR PT.mdm_price_type_name = 'Abschlusspreis' AND PS.lob_cd = 'LDL' AND PS.market_sid = 3 AND PS.incoterm_cd =
         'FOB') AS ips
     INNER JOIN ldl_p_lew_core.t_mdm_item_price_hist_2 AS IPH ON ips.mdm_price_scenario_nr = IPH.mdm_price_scenario_nr AND
        IPH.deleted_fg = 0 AND CURRENT_DATE BETWEEN IPH.dwh_valid_from AND IPH.dwh_valid_to) PIVOT (SUM(item_price) FOR
     PRICE_SCENARIO_NAME IN ('selection_purch_net_euro_price' AS SELECTION_PURCH_NET_EURO_PRICE,
     'min_target_sales_gross_euro_price' AS MIN_TARGET_SALES_GROSS_EURO_PRICE, 'plan_purch_net_euro_price' AS
     PLAN_PURCH_NET_EURO_PRICE, 'final_purch_net_euro_price' AS FINAL_PURCH_NET_EURO_PRICE,
     'initial_purch_net_euro_price' AS INITIAL_PURCH_NET_EURO_PRICE)) AS p) AS ipp ON I.mdm_item_sid = ipp.mdm_item_sid
WHERE I.item_ian <> 0
 AND IH.cbx_item_doc_status = 'active'
 AND FG.src_familygrp_cd NOT IN ('995.200')
 AND IH.item_workflow_status_id NOT IN (6);