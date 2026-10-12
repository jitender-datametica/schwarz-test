-- 

-- 1.1  26.06.2018    Thole,Jens               Bugfix: Hybrid-Ermittlung des Zielfeldes qty_disc_piece_weigth_sfo_asis (f?r WGI 1 aus SFO sonst aus EJR)

-- 

-- 1.8 24.03.2025    Domoinik Pfarr            INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for qty_disc_piece_weight_ejr_asis - only SFO should be used

-- 1.7 11.12.2024    Stefan Sockel             INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for qty_disc_piece_weight_ejr_asis - only ejr should be used

-- 1.6 11.03.2021    Kiran Nagmote             20210311_2780_Frischfish_Changes_FBO

-- 1.5 16.11.2018    Michael Strauch           20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some columns to differenziate the values by pcwo_resons

-- 1.4  06.09.2018    Chandramani Kumbhale     Three new columns (val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss, val_rtl_net_sfo_str_deliv_qlty) added for report "Abschriften - Gesamt"

-- https://jira-lidl-public.pixsoftware.de/browse/LEAD05-2535

-- 1.0  04.06.2018    Thole,Jens               Reengineering BO FLOP 10 - Stufe 1 der Basisdatenmaterialisierung

-- 1.2  17.07.2018    Thole,Jens               R?ckfall auf vor-Car; Einbau Einfachsumme; Verlagerung ITEM_MAP_KEY auf ITEMblock

-- 20180905_1820_Resns_Of_WTOF_For_FBO_Rep5
 -- Frischfisch changes , extended WG ids

-- 1.3  24.07.2018    Thole,Jens               Perfo: Ausbau des Joins auf ITEM_MAP_KEY, da nun als INNER JOIN auf V_MAT0 verlagert

-- History:
 -- https://jira-lidl-public.pixsoftware.de/browse/IDMO-1015

CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat1_bo_base_flop10 AS -- select *
 -- BASIS---------------------

-- wir lassen im Gegensatz zu v_itm_item im Mart den Rückgriff auf die WAWI-Kopie aus und habe damit einige Abweichungen.

-- ABER: diese betreffen nur Case-Size(-1)Artikel ohne Update auf WAWI-Seite - nach Update wird Klammer auf den richtigen Artikel erzeugt -

-- und tote WAWI-Artikel ohne historische Fortsetzung, damit sind diese uninteressant für den hier notwendigen Anwendungsfall.

-- Dummy-WGIs werden allesamt auf CODE '0' geschlüsselt

-- Der WGI-Code '9' steht für Frischbrot etc. Nur dieser wird zusätzlich auf SIG aufgedröselt und in den SIG-Views bereitgestellt

SELECT AGG.client_id,
 AGG.loc_sid_store,
 OS.src_wh_id AS wh_id,
 OS.loc_sid_wh,
 iia.orig_item_nr,
 iia.max_dat_valid_from,
 AGG.abstract_time_unit,
  CASE
  WHEN AGG.time_range_fg = 1
  THEN PARSE_DATE('%Y%m%d', CAST(AGG.abstract_time_unit AS STRING))
  ELSE NULL
  END AS dat_formdate,
  CASE
  WHEN AGG.time_range_fg = 2
  THEN AGG.abstract_time_unit
  ELSE NULL
  END AS cy_week,
  CASE
  WHEN AGG.time_range_fg = 3
  THEN AGG.abstract_time_unit
  ELSE NULL
  END AS cy_month,
 AGG.time_range_fg,
 MAX(iia.item_descr) AS item_desc,
 sig.itemhierarchy_cd,
 SUBSTR(sig.itemhierarchy_cd, 1, 1) AS hier_level_fg,
 SUBSTR(sig.itemhierarchy_cd, 2) AS itemhierarchy_id,
 AGG.curr_cd AS currency_iso_cd,
 SUM(AGG.val_rtl_rl_sfo) AS val_rtl_rl_sfo_store,
 SUM(AGG.val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo_store,
 SUM(AGG.val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
 SUM(AGG.val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
 SUM(AGG.val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
 SUM(AGG.val_wrtoff_zero) AS val_wrtoff_zero_store,
 SUM(AGG.val_wrtoff_zero_net) AS val_wrtoff_zero_store_net,
 SUM(AGG.val_wrtoff_zero_net_mhd_break) AS val_wrtoff_zero_store_net_mhd_break,
 SUM(AGG.val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_store_net_other_stc_loss,
 SUM(AGG.val_wrtoff_zero_net_deliv_qlty) AS val_wrtoff_zero_store_net_str_deliv_qlty,
 SUM(AGG.qty_total_sfo) AS qty_total_sfo_store,
 SUM(AGG.qty_total_sfo_mhd_break) AS qty_total_sfo_store_mhd_break,
 SUM(AGG.qty_total_sfo_other_stc_loss) AS qty_total_sfo_store_other_stc_loss,
 SUM(AGG.qty_total_sfo_str_deliv_qlty) AS qty_total_sfo_store_str_deliv_qlty,
 SUM(AGG.`_val_discount_ejr`) AS val_discount_ejr,
 SUM(AGG.`_val_discount_net_ejr`) AS val_discount_net_ejr,
 SUM(AGG.`_val_rtl_ejr_adj`) AS val_rtl_ejr_adj,
 SUM(AGG.`_val_rtl_net_ejr_adj`) AS val_rtl_net_ejr_adj,
 SUM(AGG.qty_disc_piece_weigth_sfo_asis) AS qty_disc_piece_weigth_ejr_asis,
 CAST(CASE
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'S' AND AGG.time_range_fg = 1
   THEN 'sig_day'
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'S' AND AGG.time_range_fg = 2
   THEN 'sig_week'
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'S' AND AGG.time_range_fg = 3
   THEN 'sig_mth'
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'I' AND AGG.time_range_fg = 1
   THEN 'wgi_day'
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'I' AND AGG.time_range_fg = 2
   THEN 'wgi_week'
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'I' AND AGG.time_range_fg = 3
   THEN 'wgi_mth'
   ELSE NULL
   END AS STRING) AS target_type,
 CAST(CASE
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'S' AND AGG.time_range_fg = 1
   THEN 1
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'S' AND AGG.time_range_fg = 2
   THEN 2
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'S' AND AGG.time_range_fg = 3
   THEN 3
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'I' AND AGG.time_range_fg = 1
   THEN 4
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'I' AND AGG.time_range_fg = 2
   THEN 5
   WHEN SUBSTR(sig.itemhierarchy_cd, 1, 1) = 'I' AND AGG.time_range_fg = 3
   THEN 6
   ELSE NULL
   END AS STRING) AS target_type_id
FROM ldl_p_lew_mart_msi.v_mat0_bo_base_flop10 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS OS ON AGG.client_id = OS.client_id AND AGG.loc_sid_store
   = OS.loc_sid_store
 INNER JOIN (SELECT I.client_id,
   I.item_sid,
   I.item_sid_config,
   DESCR.item_descr,
   I.src_matnr,
   ROUND(SAFE_CAST(COALESCE(I.src_orig_item_nr, I.config_item_cd, I.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
   COALESCE(I.src_dat_valid_from, MAX(I.src_dat_valid_from) OVER (PARTITION BY CAST(I.client_id AS STRING), CAST(COALESCE(I.item_sid_config, I.item_sid) AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), MAX(I.src_dat_valid_from) OVER (PARTITION BY CAST(I.client_id AS STRING)
       , I.src_orig_item_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS max_dat_valid_from,
   ITMFGH.sub_item_grp_sid
  FROM ldl_p_lew_core_ac.v_item AS I
   INNER JOIN ldl_p_lew_core_ac.v_country AS C ON I.client_id = C.country_sid
   INNER JOIN ldl_p_lew_core_ac.v_item_descr AS DESCR ON I.client_id = DESCR.client_id AND I.item_sid = DESCR.item_sid
    AND C.lang_sid = DESCR.lang_sid
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IH ON I.client_id = IH.client_id AND I.item_sid = IH.item_sid AND
     CURRENT_DATE BETWEEN IH.dwh_valid_from AND IH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS ITMFGH ON IH.client_id = ITMFGH.client_id AND IH.item_fam_grp_sid
       = ITMFGH.item_fam_grp_sid AND CURRENT_DATE BETWEEN ITMFGH.dwh_valid_from AND ITMFGH.dwh_valid_to) AS iia ON AGG.client_id
    = iia.client_id AND AGG.item_sid = iia.item_sid
 INNER JOIN (SELECT SIG.client_id,
    SIG.sub_item_grp_sid,
     'I' || CASE
      WHEN ROUND(SAFE_CAST(SIGH.item_grp_int_cd AS BIGNUMERIC), 0) < 1
      THEN '0'
      ELSE TRIM(SIGH.item_grp_int_cd)
      END AS itemhierarchy_cd
   FROM ldl_p_lew_core_ac.v_subitemgroup AS SIG
    INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON SIG.client_id = SIGH.client_id AND SIG.sub_item_grp_sid
       = SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
   UNION ALL
   SELECT SIG.client_id,
    SIG.sub_item_grp_sid,
     'S' || TRIM(SIG.src_subitemgrp_cd) AS itemhierarchy_cd
   FROM ldl_p_lew_core_ac.v_subitemgroup AS SIG
    INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SIGH ON SIG.client_id = SIGH.client_id AND SIG.sub_item_grp_sid
        = SIGH.sub_item_grp_sid AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to AND SIGH.item_grp_int_cd
       IN ('9', '90')) AS sig ON iia.client_id = sig.client_id AND iia.sub_item_grp_sid = sig.sub_item_grp_sid
GROUP BY AGG.client_id,
 AGG.loc_sid_store,
 OS.loc_sid_wh,
 wh_id,
 iia.orig_item_nr,
 iia.max_dat_valid_from,
 sig.itemhierarchy_cd,
 currency_iso_cd,
 AGG.abstract_time_unit,
 AGG.time_range_fg;