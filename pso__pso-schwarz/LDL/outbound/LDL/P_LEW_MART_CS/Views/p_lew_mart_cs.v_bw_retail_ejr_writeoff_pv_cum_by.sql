CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_retail_ejr_writeoff_pv_cum_by (client_id, land_o08_iso_code,
wg_i05_mis_wg_id, uwg_i04_mis_uwg_id, artikelfamilie_gruppiert_i04_artikelfamiliennummer, artikelart_hist_hi08_id,
waehrung_x02_bezeichnung, monat_t05_id, umsatz_ejr_aufgel, abschriften_gesamt_aufgel, preisveraenderung_aufgel) AS
-- M1401
 -- M1201BNL
 -- M1102PVS
 SELECT WH.client_id,
 WH.country_iso_cd AS land_o08_iso_code,
 SIG.itemgroup_int_id AS wg_i05_mis_wg_id,
 SIG.subitemgroup_id AS uwg_i04_mis_uwg_id,
 IFG.family_cd AS artikelfamilie_gruppiert_i04_artikelfamiliennummer,
  CASE
  WHEN BLT.buying_list_type_id IS NULL
  THEN CAST(-1 AS BIGNUMERIC)
  ELSE BLT.buying_list_type_id
  END AS artikelart_hist_hi08_id,
 COALESCE(EJR.currency_iso_cd, PRCH.currency_iso_cd, WROFF.currency_iso_cd) AS waehrung_x02_bezeichnung,
 CMD.cy_month AS monat_t05_id,
 SUM(EJR.val_ejr_cum_by) AS umsatz_ejr_aufgel,
 SUM(WROFF.val_writeoff_cum_by) AS abschriften_gesamt_aufgel,
 SUM(PRCH.val_pricechange_cum_by) AS preisveraenderung_aufgel
FROM ldl_p_lew_mart_cs.v_bw_retail_ejr_cum_by AS EJR
 FULL JOIN ldl_p_lew_mart_cs.v_bw_pricechange_cum_by AS PRCH ON EJR.aspect_id = PRCH.aspect_id AND EJR.buying_list_type_id
            = PRCH.buying_list_type_id AND EJR.client_id = PRCH.client_id AND EJR.currency_iso_cd = PRCH.currency_iso_cd
          AND EJR.curr_tot_id = PRCH.curr_tot_id AND EJR.cy_month = PRCH.cy_month AND EJR.item_familygroup_id = PRCH.item_familygroup_id
       AND EJR.subitemgroup_id = PRCH.subitemgroup_id AND EJR.subitemgroup_id0 = PRCH.subitemgroup_id0 AND EJR.wh_id =
   PRCH.wh_id
 FULL JOIN ldl_p_lew_mart_cs.v_bw_writeoff_cum_by AS WROFF ON COALESCE(EJR.aspect_id, PRCH.aspect_id) = WROFF.aspect_id
          AND COALESCE(EJR.buying_list_type_id, PRCH.buying_list_type_id) = WROFF.buying_list_type_id AND COALESCE(EJR.client_id
           , PRCH.client_id) = WROFF.client_id AND COALESCE(EJR.currency_iso_cd, PRCH.currency_iso_cd) = WROFF.currency_iso_cd
          AND COALESCE(EJR.curr_tot_id, PRCH.curr_tot_id) = WROFF.curr_tot_id AND COALESCE(EJR.cy_month, PRCH.cy_month)
       = WROFF.cy_month AND COALESCE(EJR.item_familygroup_id, PRCH.item_familygroup_id) = WROFF.item_familygroup_id AND
     COALESCE(EJR.subitemgroup_id, PRCH.subitemgroup_id) = WROFF.subitemgroup_id AND COALESCE(EJR.subitemgroup_id0, PRCH
     .subitemgroup_id0) = WROFF.subitemgroup_id0 AND COALESCE(EJR.wh_id, PRCH.wh_id) = WROFF.wh_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge AS WH ON COALESCE(EJR.aspect_id, PRCH.aspect_id, WROFF.aspect_id) = WH
    .aspect_id AND COALESCE(EJR.client_id, PRCH.client_id, WROFF.client_id) = WH.client_id AND COALESCE(EJR.wh_id, PRCH
    .wh_id, WROFF.wh_id) = WH.wh_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_subitemgroup AS SIG ON COALESCE(EJR.subitemgroup_id, PRCH.subitemgroup_id, WROFF
   .subitemgroup_id) = SIG.subitemgroup_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_buylist AS BLT ON COALESCE(EJR.buying_list_type_id, PRCH.buying_list_type_id
   , WROFF.buying_list_type_id) = CASE
   WHEN BLT.buying_list_type_id IS NULL
   THEN CAST(-1 AS BIGNUMERIC)
   ELSE BLT.buying_list_type_id
   END
 INNER JOIN ldl_p_lew_mart_msi_ac.v_itm_familygroup_int AS IFG ON COALESCE(EJR.item_familygroup_id, PRCH.item_familygroup_id
    , WROFF.item_familygroup_id) = IFG.family_cd AND COALESCE(EJR.subitemgroup_id0, PRCH.subitemgroup_id0, WROFF.subitemgroup_id0
    ) = IFG.subitemgroup_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_cal_month_desc AS CMD ON COALESCE(EJR.cy_month, PRCH.cy_month, WROFF.cy_month) = CMD
  .cy_month
GROUP BY WH.client_id,
 land_o08_iso_code,
 wg_i05_mis_wg_id,
 uwg_i04_mis_uwg_id,
 artikelfamilie_gruppiert_i04_artikelfamiliennummer,
 artikelart_hist_hi08_id,
 waehrung_x02_bezeichnung,
 monat_t05_id;