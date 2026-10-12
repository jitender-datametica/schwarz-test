CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_bo_inv_flop30_cum_1 AS
-- DT ACT
 /* DT A */ /* END DT A */ -- LKP f_itm_item_wh
 -- Alle Item_1-WH-Zuordnungen
 -- Warehouse Filter

-- LKP f_itm_item_wh
 -- Alle Item_1-WH-Zuordnungen
 -- Warehouse Filter

-- wir lassen im Gegensatz zu f_itm_item im Mart den Rückgriff auf die WAWI-Kopie aus und habe damit einige Abweichungen.

-- ABER: diese betreffen nur Case-Size(-1)Artikel_1 ohne Update auf WAWI-Seite - nach Update wird Klammer auf den richtigen Artikel_1 erzeugt -

-- und tote WAWI-Artikel_1 ohne historische Fortsetzung, damit sind diese uninteressant für den hier notwendigen Anwendungsfall.

-- wir lassen im Gegensatz zu f_itm_item im Mart den Rückgriff auf die WAWI-Kopie aus und habe damit einige Abweichungen.

-- ABER: diese betreffen nur Case-Size(-1)Artikel_1 ohne Update auf WAWI-Seite - nach Update wird Klammer auf den richtigen Artikel_1 erzeugt -

-- und tote WAWI-Artikel_1 ohne historische Fortsetzung, damit sind diese uninteressant für den hier notwendigen Anwendungsfall.

SELECT 
 act.client_id AS client_id,
 RCD.country_desc AS country_desc,
 RCD.country_id AS country_id,
 RCT.country_iso_cd AS country_iso_cd,
 act.store_id AS store_id,
 OSA.src_orig_store_nr AS orig_store_nr,
 COALESCE(OSA.loc_name, OSA.loc_name2) AS store_desc,
 OSC.city AS city,
 act.wh_id AS wh_id,
 COALESCE(OWH.loc_name, OWH.loc_name2) AS wh_desc,
 act.sales_manager_id AS sales_manager_id,
 act.sales_manager_name AS sales_manager_name,
 act.account_manager_id AS account_manager_id,
 act.account_manager_name AS account_manager_name,
 act.busyear AS busyear,
 act.itm_consgrp_id AS itm_consgrp_id,
 act.cons_orig_item_nr AS cons_orig_item_nr,
 act.cons_dat_valid_from_item AS cons_dat_valid_from_item,
 act.itm_consgrp_desc AS itm_consgrp_desc,
 act.cons_item_desc AS cons_item_desc,
 act.currency_iso_cd AS currency_iso_cd,
 act.val_rtl_ejr_adj_cum AS val_rtl_ejr_adj_cum,
 act.val_rtl_net_ejr_adj_cum AS val_rtl_net_ejr_adj_cum,
 act.diff_inv_stc_calc_val_cum AS diff_inv_stc_calc_val_cum,
 act.diff_inv_stc_calc_val_cum_net AS diff_inv_stc_calc_val_cum_net,
 act.diff_inv_stc_calc_cnt_cum AS diff_inv_stc_calc_cnt_cum,
 ROUND(CAST(COALESCE(act.diff_inv_stc_calc_val_cum / CASE
       WHEN act.val_rtl_ejr_adj_cum = 0
       THEN NULL
       ELSE act.val_rtl_ejr_adj_cum
       END, 0) * 100 AS BIGNUMERIC), 4) AS inv_diff_to_val_rtl_pct_cum,
 ROUND(CAST(COALESCE(act.diff_inv_stc_calc_val_cum_net / CASE
       WHEN act.val_rtl_net_ejr_adj_cum = 0
       THEN NULL
       ELSE act.val_rtl_net_ejr_adj_cum
       END, 0) * 100 AS BIGNUMERIC), 4) AS inv_dif_to_val_rtl_net_pct_cum,
 ROW_NUMBER() OVER (PARTITION BY act.client_id, act.store_id, CAST(act.busyear AS STRING), act.currency_iso_cd ORDER BY
    ABS(act.diff_inv_stc_calc_val_cum) IS NULL, ABS(act.diff_inv_stc_calc_val_cum), ABS(act.diff_inv_stc_calc_cnt_cum)
    IS NULL, ABS(act.diff_inv_stc_calc_cnt_cum), act.itm_consgrp_id IS NULL, act.itm_consgrp_id, act.cons_orig_item_nr
    IS NULL, act.cons_orig_item_nr, act.cons_dat_valid_from_item IS NULL, act.cons_dat_valid_from_item) AS rnk_inv
FROM (SELECT a.client_id,
   a.store_id,
   COALESCE(MGR_INFOS.sales_manager_id, - 100) AS sales_manager_id,
   COALESCE(MGR_INFOS.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
   COALESCE(MGR_INFOS.account_manager_id, - 1) AS account_manager_id,
   COALESCE(MGR_INFOS.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
   OSS.loc_sid_wh,
   OSS.src_wh_id AS wh_id,
   a.busyear,
   cons.itm_consgrp_id,
   cons.cons_orig_item_nr,
   cons.cons_dat_valid_from_item,
   cons.itm_consgrp_desc,
    CASE
    WHEN cons.itm_consgrp_id = - 1
    THEN cons.item_descr
    ELSE NULL
    END AS cons_item_desc,
   CRY.curr_cd AS currency_iso_cd,
   SUM(a.val_rtl_ejr_adj_cum) AS val_rtl_ejr_adj_cum,
   SUM(a.val_rtl_net_ejr_adj_cum) AS val_rtl_net_ejr_adj_cum,
   SUM(a.diff_inv_stc_calc_val_cum) AS diff_inv_stc_calc_val_cum,
   SUM(a.diff_inv_stc_calc_val_cum_net) AS diff_inv_stc_calc_val_cum_net,
   SUM(a.diff_inv_stc_calc_cnt_cum) AS diff_inv_stc_calc_cnt_cum
  FROM (SELECT A.client_id,
     A.st_loc_sid AS store_id,
     A.item_sid AS item_id,
     B.busyear,
     SUM(A.val_rtl_ejr + A.val_return_ejr) AS val_rtl_ejr_adj_cum,
     SUM(A.val_rtl_net_ejr + A.val_return_net_ejr) AS val_rtl_net_ejr_adj_cum,
     SUM(A.diff_inv_stc_calc_val) AS diff_inv_stc_calc_val_cum,
     SUM(A.diff_inv_stc_calc_net_val) AS diff_inv_stc_calc_val_cum_net,
     SUM(A.diff_inv_stc_calc_cnt) AS diff_inv_stc_calc_cnt_cum,
     MAX(A.dat_formdate) AS last_dat_formdate
    FROM ldl_p_lew_bil_ac.v_agg_store_item_inv_all_wawi_1 AS A
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS B ON A.dat_formdate = B.cal_dt AND A.cy_month = B.cy_month
    WHERE B.busyear_seq IN (0, - 1)
    GROUP BY A.client_id,
     store_id,
     item_id,
     B.busyear) AS a
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS OSS ON a.client_id = OSS.client_id AND a.store_id = OSS
     .loc_sid_store -- LKP item_1-consolidation; v_msi_view.v_itm_item_consolidation_1

   INNER JOIN (SELECT i.client_id,
     i.wh_id,
     i.item_id,
     i.itm_consgrp_id,
     i.cons_item_id,
      CASE
      WHEN i.itm_consgrp_id = - 1
      THEN a.orig_item_nr
      ELSE CAST(- 1 AS BIGNUMERIC)
      END AS cons_orig_item_nr,
      CASE
      WHEN i.itm_consgrp_id = - 1
      THEN a.dat_valid_from
      ELSE DATE '1900-01-01'
      END AS cons_dat_valid_from_item,
      CASE
      WHEN i.itm_consgrp_id = - 1
      THEN 0
      ELSE 1
      END AS cons_fg,
     CGP.itm_consgrp_desc,
     a.item_descr
    FROM (SELECT i1.client_id,
        i1.wh_id,
        i1.item_id,
        C1.itm_consgrp_id,
        CAST(- 1 AS BIGNUMERIC) AS cons_item_id
       FROM (SELECT B.client_id,
          F.loc_sid_wh AS wh_id,
          B.item_sid AS item_id,
          B.dwh_valid_from AS dat_rec_start,
          B.dwh_valid_to AS dat_rec_end
         FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS B
          INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS F ON B.client_id = F.client_id AND B.loc_sid = F.loc_sid_wh AND F.dwh_actual_fg
                 = 1 AND F.deleted_fg = 0 AND F.bges_active_fg = 1 AND B.deleted_fg = 0 AND CURRENT_DATE BETWEEN B.dwh_valid_from
            AND B.dwh_valid_to) AS i1
        INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS C1 ON i1.client_id = C1.client_id AND i1.item_id =
           C1.item_sid AND i1.wh_id = C1.wh_loc_sid
       WHERE CURRENT_DATE BETWEEN C1.dat_rec_start AND C1.dat_rec_end
        AND CURRENT_DATE BETWEEN i1.dat_rec_start AND i1.dat_rec_end
       UNION ALL
       SELECT client_id,
        wh_id,
        item_id,
        CAST(- 1 AS BIGNUMERIC) AS itm_consgrp_id,
        item_id AS cons_item_id
       FROM (SELECT B.client_id,
          F.loc_sid_wh AS wh_id,
          B.item_sid AS item_id,
          B.dwh_valid_from AS dat_rec_start,
          B.dwh_valid_to AS dat_rec_end
         FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS B
          INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS F ON B.client_id = F.client_id AND B.loc_sid = F.loc_sid_wh AND F.dwh_actual_fg
                 = 1 AND F.deleted_fg = 0 AND F.bges_active_fg = 1 AND B.deleted_fg = 0 AND CURRENT_DATE BETWEEN B.dwh_valid_from
            AND B.dwh_valid_to) AS i2
       WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
        AND NOT EXISTS (SELECT 1
         FROM ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS C2
         WHERE i2.client_id = client_id
          AND i2.item_id = item_sid
          AND i2.wh_id = wh_loc_sid
          AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)) AS i
     INNER JOIN (SELECT I.client_id,
       I.item_sid,
       I.item_sid_config,
       DESCR.item_descr,
       I.src_matnr,
       I.src_dat_valid_from AS dat_valid_from,
       ROUND(SAFE_CAST(COALESCE(I.src_orig_item_nr, I.config_item_cd, I.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
       COALESCE(I.src_dat_valid_from, MAX(I.src_dat_valid_from) OVER (PARTITION BY CAST(I.client_id AS STRING), CAST(COALESCE(I.item_sid_config, I.item_sid) AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), MAX(I.src_dat_valid_from) OVER (PARTITION BY CAST(I.client_id AS STRING)
           , I.src_orig_item_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS max_dat_valid_from,
       ITMFGH.sub_item_grp_sid
      FROM ldl_p_lew_core_ac.v_item_1 AS I
       INNER JOIN ldl_p_lew_core_ac.v_country_1 AS C ON I.client_id = C.country_sid
       INNER JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR ON I.client_id = DESCR.client_id AND I.item_sid = DESCR.item_sid
           AND C.lang_sid = DESCR.lang_sid
       INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS IH ON I.client_id = IH.client_id AND I.item_sid = IH.item_sid AND
         CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
       INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_1 AS ITMFGH ON IH.client_id = ITMFGH.client_id AND IH.item_fam_grp_sid
           = ITMFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH.dwh_valid_from AND ITMFGH.dwh_valid_to) AS a ON i.client_id
        = a.client_id AND i.item_id -- Da nicht integriert ist, wird auf die Legacy referenziert
 = a.item_sid
     LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup_1 AS CGP ON i.client_id = CGP.client_id AND i.wh_id = CGP.wh_loc_sid
          AND i.itm_consgrp_id = CGP.itm_consgrp_id AND CURRENT_DATE BETWEEN CGP.dat_rec_start AND CGP.dat_rec_end) AS
   cons ON a.client_id = cons.client_id AND OSS.loc_sid_wh = cons.wh_id AND a.item_id = cons.item_id
     -- Fuer die Logik v_view.v_itm_item_act_1 iia -> Logik aus show view p_lew_mart_msi.v_mat1_bo_base_flop10_1

     -- LKP subitemgroup -->  EXCLUDE WAWI f_itm_item.subitemgroup_id 996

   INNER JOIN (SELECT I0.client_id,
     I0.item_sid,
     I0.item_sid_config,
     DESCR0.item_descr,
     I0.src_matnr,
     ROUND(SAFE_CAST(COALESCE(I0.src_orig_item_nr, I0.config_item_cd, I0.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
     COALESCE(I0.src_dat_valid_from, MAX(I0.src_dat_valid_from) OVER (PARTITION BY CAST(I0.client_id AS STRING), CAST(COALESCE(I0.item_sid_config, I0.item_sid) AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), MAX(I0.src_dat_valid_from) OVER (PARTITION BY CAST(I0.client_id AS STRING)
         , I0.src_orig_item_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS max_dat_valid_from,
     ITMFGH0.sub_item_grp_sid,
     SIG.src_subitemgrp_cd,
     SIG.sub_item_grp_name,
     SIG.item_grp_int_sid,
     SIG.lang_cd_default,
     SIG.deleted_fg,
     SIG.active_fg
    FROM ldl_p_lew_core_ac.v_item_1 AS I0
     INNER JOIN ldl_p_lew_core_ac.v_country_1 AS C0 ON I0.client_id = C0.country_sid
     INNER JOIN ldl_p_lew_core_ac.v_item_descr_1 AS DESCR0 ON I0.client_id = DESCR0.client_id AND I0.item_sid = DESCR0.item_sid
         AND C0.lang_sid = DESCR0.lang_sid
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS IH0 ON I0.client_id = IH0.client_id AND I0.item_sid = IH0.item_sid AND
       CURRENT_DATE BETWEEN IH0.dwh_valid_from AND IH0.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_1 AS ITMFGH0 ON IH0.client_id = ITMFGH0.client_id AND IH0.item_fam_grp_sid
         = ITMFGH0.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH0.dwh_valid_from AND ITMFGH0.dwh_valid_to
     INNER JOIN ldl_p_lew_bil_ac.v_subitemgroup_1 AS SIG ON I0.client_id = SIG.client_id AND ITMFGH0.sub_item_grp_sid =
       SIG.sub_item_grp_sid) AS iia ON a.client_id = iia.client_id AND a.item_id = iia.item_sid
     -- LKP Manager Infos (Sales_1- und Account_1-Manager) --> extrahiert aus V_MAT_ORG_SALES_MANAGER_1 und V_MAT_ORG_ACCOUNT_MANAGER_1

     
   LEFT JOIN ldl_p_lew_bil_ac.v_location_organization_1 AS MGR_INFOS ON OSS.client_id = MGR_INFOS.client_id AND OSS.loc_sid_wh
       = MGR_INFOS.loc_sid_wh AND OSS.loc_sid_store = MGR_INFOS.loc_sid_store -- Lookup curr_cd

   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CRY ON a.client_id = CRY.client_id
  WHERE CAST(iia.src_subitemgrp_cd AS FLOAT64) <> 996
  GROUP BY a.client_id,
   a.store_id,
   MGR_INFOS.sales_manager_id,
   MGR_INFOS.sales_manager_name,
   MGR_INFOS.account_manager_id,
   MGR_INFOS.account_manager_name,
   OSS.loc_sid_wh,
   wh_id,
   a.busyear,
   cons.itm_consgrp_id,
   cons.cons_orig_item_nr,
   cons.cons_dat_valid_from_item,
   cons.itm_consgrp_desc,
   cons_item_desc,
   currency_iso_cd) AS act
 INNER JOIN ldl_p_lew_bil_ac.v_store_1 AS OSA ON act.client_id = OSA.client_id AND act.store_id = OSA.loc_sid_store AND
      OSA.dwh_actual_fg = 1 AND OSA.deleted_fg = 0 AND OSA.test_store_fg = 0 AND OSA.pseudo_store_fg = 0
   -- v_view.v_org_store_contact_1

 INNER JOIN ldl_p_lew_core_ac.v_address_1 AS OSC ON OSA.client_id = OSC.client_id AND OSA.addr_sid = OSC.addr_sid
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS OWH ON act.client_id = OWH.client_id AND act.loc_sid_wh = OWH.loc_sid_wh AND
     OWH.dwh_actual_fg = 1 AND OWH.bges_active_fg = 1 AND OWH.deleted_fg = 0
   -- LKP Country_ID --> Im Unterschied zu V_CLIENT_1 ist hier noch nicht Serbien enthalten.

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS RCC ON act.client_id = RCC.client_id
  -- LKP Country_Desc (Landesname)

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_act_1 AS RCT ON RCC.country_id = RCT.country_id AND RCT.language_id = RCT
   .country_id -- LKP Country_ISO_CD

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_desc_1 AS RCD ON RCC.country_id = RCD.country_id AND RCD.language_id =
   RCD.country_id
WHERE act.diff_inv_stc_calc_val_cum <> 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY act.client_id, act.store_id, CAST(act.busyear AS STRING), act.currency_iso_cd
    ORDER BY ABS(act.diff_inv_stc_calc_val_cum) IS NULL, ABS(act.diff_inv_stc_calc_val_cum), ABS(act.diff_inv_stc_calc_cnt_cum
       ) IS NULL, ABS(act.diff_inv_stc_calc_cnt_cum), act.itm_consgrp_id IS NULL, act.itm_consgrp_id, act.cons_orig_item_nr
      IS NULL, act.cons_orig_item_nr, act.cons_dat_valid_from_item IS NULL, act.cons_dat_valid_from_item)) <= 30;