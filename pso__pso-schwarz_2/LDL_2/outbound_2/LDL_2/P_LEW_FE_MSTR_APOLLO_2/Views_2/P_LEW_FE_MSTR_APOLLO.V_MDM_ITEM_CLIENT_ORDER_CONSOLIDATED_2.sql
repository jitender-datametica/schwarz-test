/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_CONSOLIDATED_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#  1.1  13.04.2022    Aparna Rayanki               Added column selection_purch_net_euro_price joining with V_MDM_ITEM_HIST_2 
#                                                  to improve Performance of MSTR report 'AM Tagesreporting'
#  1.2  23.05.2022    Aparna Rayanki               Added filter and additional columns 
#                                                  to improve Performance of MSTR report 'AM Tagesreporting'
#  1.3  17.06.2022    Aparna Rayanki               Added additional columns
#  1.4  06.02.2023    Aparna Rayanki               Filter applied to get active items and filter out rejected items
#                                                  removed prices from item_hist
#  1.5  16.02.2023    Aparna Rayanki               Added Säule and corrected ek_net_volume logic
#----------------------------------------------------------------------------
*/


-- ,LTRIM(CAST(listAgg(TRIM(icodh.cy_week_delivery),',') WITHIN GROUP (ORDER BY icodh.country_del_seq_nr) AS STRING(100) ),',') AS cy_week_delivery

CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_order_consolidated_2 (client_id, mdm_item_sid,
mdm_item_name, client_id_order, client_cd, lob_cd, client_block_id_order, item_ian, range_plan_cd, step_item_nr,
max_set_multipack_fg, item_workflow_status_id, item_fam_grp_sid, brand_sid, country_pol_sid_origin, mdm_sup_sid,
ean_ownership_cd, sup_final_fg, market_sid, kfl_brand_sid, item_quality_class_cd, item_class_cd, cbx_order_version,
cy_week_advertise, cy_week_import, client_sell_from_dt, client_order_carton_weight, client_order_total_qty,
client_order_total_carton_qty, client_order_notes, ldl_store_cnt, kfl_large_store_cnt, kfl_small_store_cnt,
purch_net_euro_price, sales_vat_pct, sales_gross_euro_price, ek_net_volume, min_cy_week_delivery,
min_cy_week_delivery_real_fg, from_cal_dt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS -- ,icodh.cy_week_delivery
 /* items rejected */ SELECT /* Client_Order * */ ICO.client_id,
 ICO.mdm_item_sid,
 I.mdm_item_name,
 ICO.client_id_order,
 ICO.client_cd,
 CT.lob_cd,
 ICO.client_block_id_order,
 I.item_ian,
 I.range_plan_cd,
 I.step_item_nr,
 iset.max_set_multipack_fg,
 IH.item_workflow_status_id,
 IH.item_fam_grp_sid,
 IH.brand_sid,
 IH.country_pol_sid_origin,
 IH.mdm_sup_sid,
 IH.ean_ownership_cd,
 IH.sup_final_fg,
 IH.market_sid,
 IH.kfl_brand_sid,
 IH.item_quality_class_cd,
 IH.item_class_cd /* Client_Order_Hist * */,
 ICOH.cbx_order_version,
 ICOH.cy_week_advertise,
 ICOH.cy_week_import,
 ICOH.client_sell_from_dt,
 ICOH.client_order_carton_weight,
 ICOH.client_order_total_qty,
 ICOH.client_order_total_carton_qty,
 ICOH.client_order_notes,
 ICOH.ldl_store_cnt,
 ICOH.kfl_large_store_cnt,
 ICOH.kfl_small_store_cnt,
 ICOH.purch_net_euro_price,
  CASE
  WHEN ICO.client_id_order BETWEEN 2000 AND 3999 AND ICOH.sales_vat_pct BETWEEN 1 AND 1.9
  THEN (ICOH.sales_vat_pct - 1) * 100
  ELSE ICOH.sales_vat_pct
  END AS sales_vat_pct,
 ICOH.sales_gross_euro_price,
  ICOH.client_order_total_qty * CASE
   WHEN ICOH.purch_net_euro_price IS NULL
   THEN ipp.selection_purch_net_euro_price
   ELSE ICOH.purch_net_euro_price
   END AS ek_net_volume,
 icodh.min_cy_week_delivery,
 icodh.min_cy_week_delivery_real_fg,
 IF(icodh.min_cy_week_delivery_real_fg = 0, DATE('9999-12-30'), CW.from_cal_dt) AS from_cal_dt,
 ICOH.deleted_fg,
 ICOH.dwh_valid_from,
 ICOH.dwh_valid_to,
 ICOH.dwh_load_id,
 ICOH.dwh_created,
 ICOH.dwh_updated
FROM ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_order_2 AS ICO
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_order_hist_2 AS ICOH ON ICO.mdm_item_sid = ICOH.mdm_item_sid AND
     ICO.client_id_order = ICOH.client_id_order AND CURRENT_DATE BETWEEN ICOH.dwh_valid_from AND ICOH.dwh_valid_to AND
   ICOH.deleted_fg = 0
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_item_2 AS I ON ICO.mdm_item_sid = I.mdm_item_sid
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_item_hist_2 AS IH ON I.mdm_item_sid = IH.mdm_item_sid AND CURRENT_DATE BETWEEN
    IH.dwh_valid_from AND IH.dwh_valid_to AND IH.deleted_fg = 0
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_item_familygroup_2 AS FG ON IH.item_fam_grp_sid = FG.item_fam_grp_sid
 INNER JOIN ldl_p_lew_fe_mstr_apollo.v_mdm_client_2 AS CT ON ICO.client_id_order = CT.client_id
 LEFT JOIN (SELECT mdm_item_sid,
   client_id_order,
   MIN(CASE
     WHEN country_delivery_qty > 0
     THEN cy_week_delivery
     ELSE NULL
     END) AS min_cy_week_delivery,
   IF(SAFE_CAST(SUBSTR(SUBSTR(CAST(MIN(CASE
           WHEN country_delivery_qty > 0
           THEN cy_week_delivery
           ELSE NULL
           END) AS STRING), 1, 39), 5, 2) as FLOAT64) = 99, 0, 1) AS min_cy_week_delivery_real_fg
  FROM ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_order_delivery_hist_2 AS ICODH
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND deleted_fg = 0
  GROUP BY mdm_item_sid,
   client_id_order) AS icodh ON ICO.mdm_item_sid = icodh.mdm_item_sid AND ICO.client_id_order = icodh.client_id_order
 LEFT JOIN ldl_p_lew_core.t_cal_week_partial_2 AS CW ON icodh.min_cy_week_delivery = CW.cy_week AND CW.cy_week_part = 1
 LEFT JOIN (SELECT mdm_item_sid,
   MAX(set_multipack_fg) AS max_set_multipack_fg,
   COUNT(DISTINCT set_multipack_fg) AS dist_set_multipack_fg
  FROM ldl_p_lew_fe_mstr_apollo.v_mdm_item_set_2
  GROUP BY mdm_item_sid) AS iset ON I.mdm_item_sid = iset.mdm_item_sid /* Lookup selection_purch_net_euro_price */
 LEFT JOIN (SELECT IPH.mdm_item_sid,
   IPH.item_price AS selection_purch_net_euro_price
  FROM (SELECT PS.mdm_price_scenario_nr
    FROM ldl_p_lew_core.t_mdm_price_scenario_2 AS PS
     INNER JOIN ldl_p_lew_core.t_mdm_price_type_2 AS PT ON PS.mdm_price_type_cd = PT.mdm_price_type_cd
    WHERE PT.mdm_price_type_name = 'EK-Preis AM' -- selection_purch_net_euro_price
) AS ips
   INNER JOIN ldl_p_lew_core.t_mdm_item_price_hist_2 AS IPH ON ips.mdm_price_scenario_nr = IPH.mdm_price_scenario_nr AND
      IPH.deleted_fg = 0 AND CURRENT_DATE BETWEEN IPH.dwh_valid_from AND IPH.dwh_valid_to) AS ipp ON I.mdm_item_sid =
  ipp.mdm_item_sid
WHERE I.item_ian <> 0
 AND IH.cbx_item_doc_status = 'active' /* Active items */
 AND FG.src_familygrp_cd NOT IN ('995.200')
 AND IH.item_workflow_status_id NOT IN (6);