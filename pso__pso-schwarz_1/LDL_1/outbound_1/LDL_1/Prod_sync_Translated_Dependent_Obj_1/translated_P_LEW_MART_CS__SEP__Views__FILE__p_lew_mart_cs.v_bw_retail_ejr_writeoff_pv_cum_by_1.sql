CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_retail_ejr_writeoff_pv_cum_by_1 (client_id, `land_1 o08 iso-code`,
`wg i05 mis wg id`, 
`uwg i04 mis uwg id`, 
`artikelfamilie gruppiert i04 artikelfamiliennummer`,
`artikelart _u0028_hist_u0029_ hi08 id`, 
`waehrung x02 bezeichnung`, 
`monat_1 t05 id`, 
`umsatz ejr aufgel`, 
`abschriften_1 gesamt aufgel`, 
`preisveraenderung aufgel`) AS -- M1401

-- M1201BNL
 -- M1102PVS
 SELECT WH.client_id,
 WH.country_iso_cd AS `land_1 o08 iso-code`,
 SIG.itemgroup_int_id AS `wg i05 mis wg id`,
 SIG.subitemgroup_id AS `uwg i04 mis uwg id`,
 IFG.family_cd AS `artikelfamilie gruppiert i04 artikelfamiliennummer`,
  CASE
  WHEN BLT.buying_list_type_id IS NULL
  THEN CAST(-1 AS BIGNUMERIC)
  ELSE BLT.buying_list_type_id
  END AS `artikelart _u0028_hist_u0029_ hi08 id`,
 COALESCE(EJR.currency_iso_cd, PRCH.currency_iso_cd, WROFF.currency_iso_cd) AS `waehrung x02 bezeichnung`,
 CMD.cy_month AS `monat_1 t05 id`,
 SUM(EJR.val_ejr_cum_by) AS `umsatz ejr aufgel`,
 SUM(WROFF.val_writeoff_cum_by) AS `abschriften_1 gesamt aufgel`,
 SUM(PRCH.val_pricechange_cum_by) AS `preisveraenderung aufgel`
FROM ldl_p_lew_mart_cs.v_bw_retail_ejr_cum_by_1 AS EJR
 FULL JOIN ldl_p_lew_mart_cs.v_bw_pricechange_cum_by_1 AS PRCH ON EJR.aspect_id = PRCH.aspect_id AND EJR.buying_list_type_id
            = PRCH.buying_list_type_id AND EJR.client_id = PRCH.client_id AND EJR.currency_iso_cd = PRCH.currency_iso_cd
          AND EJR.curr_tot_id = PRCH.curr_tot_id AND EJR.cy_month = PRCH.cy_month AND EJR.item_familygroup_id = PRCH.item_familygroup_id
       AND EJR.subitemgroup_id = PRCH.subitemgroup_id AND EJR.subitemgroup_id0 = PRCH.subitemgroup_id0 AND EJR.wh_id =
   PRCH.wh_id
 FULL JOIN ldl_p_lew_mart_cs.v_bw_writeoff_cum_by_1 AS WROFF ON COALESCE(EJR.aspect_id, PRCH.aspect_id) = WROFF.aspect_id
          AND COALESCE(EJR.buying_list_type_id, PRCH.buying_list_type_id) = WROFF.buying_list_type_id AND COALESCE(EJR.client_id
           , PRCH.client_id) = WROFF.client_id AND COALESCE(EJR.currency_iso_cd, PRCH.currency_iso_cd) = WROFF.currency_iso_cd
          AND COALESCE(EJR.curr_tot_id, PRCH.curr_tot_id) = WROFF.curr_tot_id AND COALESCE(EJR.cy_month, PRCH.cy_month)
       = WROFF.cy_month AND COALESCE(EJR.item_familygroup_id, PRCH.item_familygroup_id) = WROFF.item_familygroup_id AND
     COALESCE(EJR.subitemgroup_id, PRCH.subitemgroup_id) = WROFF.subitemgroup_id AND COALESCE(EJR.subitemgroup_id0, PRCH
     .subitemgroup_id0) = WROFF.subitemgroup_id0 AND COALESCE(EJR.wh_id, PRCH.wh_id) = WROFF.wh_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_1 AS WH ON COALESCE(EJR.aspect_id, PRCH.aspect_id, WROFF.aspect_id) = WH
    .aspect_id AND COALESCE(EJR.client_id, PRCH.client_id, WROFF.client_id) = WH.client_id AND COALESCE(EJR.wh_id, PRCH
    .wh_id, WROFF.wh_id) = WH.wh_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup_1 AS SIG ON COALESCE(EJR.subitemgroup_id, PRCH.subitemgroup_id, WROFF
   .subitemgroup_id) = SIG.subitemgroup_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_buylist_1 AS BLT ON COALESCE(EJR.buying_list_type_id, PRCH.buying_list_type_id
   , WROFF.buying_list_type_id) = CASE
   WHEN BLT.buying_list_type_id IS NULL
   THEN CAST(-1 AS BIGNUMERIC)
   ELSE BLT.buying_list_type_id
   END
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_familygroup_int_1 AS IFG ON COALESCE(EJR.item_familygroup_id, PRCH.item_familygroup_id
    , WROFF.item_familygroup_id) = IFG.family_cd AND COALESCE(EJR.subitemgroup_id0, PRCH.subitemgroup_id0, WROFF.subitemgroup_id0
    ) = IFG.subitemgroup_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc_1 AS CMD ON COALESCE(EJR.cy_month, PRCH.cy_month, WROFF.cy_month) = CMD
  .cy_month
GROUP BY WH.client_id,
 `land_1 o08 iso-code`,
 `wg i05 mis wg id`,
 `uwg i04 mis uwg id`,
 `artikelfamilie gruppiert i04 artikelfamiliennummer`,
 `artikelart _u0028_hist_u0029_ hi08 id`,
 `waehrung x02 bezeichnung`,
 `monat_1 t05 id`;