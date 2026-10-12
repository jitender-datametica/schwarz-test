-- 1.3 16.11.2018    Michael Strauch           20181113_1882_Differ_writeoff_reasons_FBO_Rep1 - extended by some columns to differenziate the values by pcwo_resons

-- https://jira-lidl-public.pixsoftware.de/browse/IDMO-1015
 -- History:

-- 1.6 11.12.2024    Stefan Sockel             INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for val_rtl_net_sfo_mhd_break_discount - only ejr should be used

-- 20180905_1820_Resns_Of_WTOF_For_FBO_Rep5

-- 1.2  06.09.2018    Chandramani Kumbhale     Three new columns (val_rtl_net_sfo_mhd_break, val_rtl_net_sfo_other_stc_loss, val_rtl_net_sfo_str_deliv_qlty) added for report "Abschriften - Gesamt"

-- 
 -- 1.5 11.03.2021    Kiran Nagmote             20210311_2780_Frischfish_Changes_FBO

-- 1.7 24.03.2025	  Dominik Pfarr             INC9229115 - Remove case for WGI 10 that used SFO instead of EJR for val_rtl_net_sfo_mhd_break_discount - only SFO should be used

-- 1.4 05.02.2019    Michael Mzyk              20190204_1948_Modification_Flop_10_Report_Rep1 - modification of order login in fields rank_abs and rank_rel

-- https://jira-lidl-public.pixsoftware.de/browse/LEAD05-2535

-- 1.0  04.06.2018    Thole,Jens               Reengineering BO FLOP 10 - Endstufe der Basisdatenmaterialisierung

-- Frischfisch changes , extended WG ids
 -- 

-- 1.8 09.05.2025	  Stefan Sockel             INC10730738 - Change to use EJR for val_rtl_net_sfo_mhd_break_discount to correct flop 10 selection and sorting in Item and SIG

-- 1.1  25.07.2018    Thole,Jens               Umstellung auf logisches BIL-Objekt v_location_organization

CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_bo_base_flop10
OPTIONS(DESCRIPTION = `TOP LEVEL VIEW FOR PROCESSING DATA FOR LEW_MART_MSI.T_BO_BASE_FLOP10`) AS
/* sfo_to_val_retail_mhd_break_discount_pct  (Definition siehe unten) ersetzt das frühere Rankingkriterium: sfo_to_val_retail_pct.	
                                      Dieses neue Rankingkriterium steht für die Nettosumme aus Abschriften Filiale und Rabattierung in Relation zum Gesamtnettoumsatz (relative Wertebetrachtung).	
                                      Fachlicher Hintergrund ist wie bei rank_abs, dass auch stark rabattierte Artikel mit ansonsten niedrigeren Abs Fil im Ranking berücksichtigt werden sollen. */
-- BASIS--------------------------------
 -- 
 SELECT ag2.target_type,
 ag2.target_type_id,
 COALESCE(SAM.account_manager_id, - 1) AS account_manager_id,
 COALESCE(SAM.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
 COALESCE(SAM.sales_manager_id, - 100) AS sales_manager_id,
 COALESCE(SAM.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
 OSC.city,
 RCT.country_id,
 RCT.country_desc,
 RCT.country_iso_cd,
 OSA.src_orig_store_nr AS orig_store_nr,
 COALESCE(OSA.loc_name2, OSA.loc_name) AS store_desc,
 COALESCE(OWH.loc_name2, OWH.loc_name) AS wh_desc,
 ag2.client_id,
 ag2.loc_sid_store AS store_id,
 ag2.wh_id,
 ag2.orig_item_nr,
 ag2.dat_valid_from,
 ag2.item_desc,
 ag2.subitemgroup_id,
 ag2.item_wgi_id,
 ag2.dat_formdate,
 ag2.cy_week,
 ag2.cy_month,
 ag2.currency_iso_cd,
 ag2.val_rtl_rl_sfo_store,
 ag2.val_rtl_rl_net_sfo_store,
 ag2.val_rtl_net_sfo_mhd_break,
 ag2.val_rtl_net_sfo_other_stc_loss,
 ag2.val_rtl_net_sfo_str_deliv_qlty,
 ag2.val_wrtoff_zero_store,
 ag2.val_wrtoff_zero_store_net,
 ag2.val_wrtoff_zero_store_net_mhd_break,
 ag2.val_wrtoff_zero_store_net_other_stc_loss,
 ag2.val_wrtoff_zero_store_net_str_deliv_qlty,
 ag2.qty_total_sfo_store,
 ag2.qty_total_sfo_store_mhd_break,
 ag2.qty_total_sfo_store_other_stc_loss,
 ag2.qty_total_sfo_store_str_deliv_qlty,
 ag2.qty_disc_piece_weigth_ejr_asis,
 ag2.val_discount_ejr AS val_discount_sfo,
 ag2.val_discount_net_ejr AS val_discount_net_sfo,
 ag2.val_rtl_ejr_adj,
 ag2.val_rtl_net_ejr_adj,
 ag2.sfo_to_val_retail_pct,
 ag2.sfo_to_val_retail_net_pct,
 ag2.wrtoff_zero_to_val_retail_pct,
 ag2.wrtoff_zero_to_val_retail_net_pct,
 ag2.discount_sfo_to_val_retail_pct,
 ag2.discount_sfo_to_val_retail_net_pct,
 ROW_NUMBER() OVER (PARTITION BY CAST(ag2.client_id AS STRING), CAST(ag2.loc_sid_store AS STRING), CAST(ag2.wh_id AS STRING)
    , ag2.abstract_item_hierarchy_id, CAST(ag2.abstract_time_unit AS STRING), ag2.currency_iso_cd, ag2.target_type
  ORDER BY COALESCE(ag2.val_rtl_net_sfo_mhd_break_discount, 0) IS NULL, COALESCE(ag2.val_rtl_net_sfo_mhd_break_discount
     , 0), ag2.orig_item_nr IS NULL, ag2.orig_item_nr) AS rank_abs,
 ROW_NUMBER() OVER (PARTITION BY CAST(ag2.client_id AS STRING), CAST(ag2.loc_sid_store AS STRING), CAST(ag2.wh_id AS STRING)
    , ag2.abstract_item_hierarchy_id, CAST(ag2.abstract_time_unit AS STRING), ag2.currency_iso_cd, ag2.target_type
  ORDER BY COALESCE(ag2.sfo_to_val_retail_mhd_break_discount_pct, 0) IS NULL, COALESCE(ag2.sfo_to_val_retail_mhd_break_discount_pct
     , 0), ag2.orig_item_nr IS NULL, ag2.orig_item_nr) AS rank_rel
FROM (SELECT target_type,
   target_type_id,
   client_id,
   loc_sid_store,
   loc_sid_wh,
   wh_id,
   orig_item_nr,
   max_dat_valid_from AS dat_valid_from,
   item_desc,
   itemhierarchy_cd AS abstract_item_hierarchy_id,
    CASE
    WHEN hier_level_fg = 'S'
    THEN ROUND(CAST(itemhierarchy_id AS BIGNUMERIC), 0)
    ELSE NULL
    END AS subitemgroup_id,
    CASE
    WHEN hier_level_fg = 'I'
    THEN ROUND(CAST(itemhierarchy_id AS BIGNUMERIC), 0)
    ELSE NULL
    END AS item_wgi_id,
   abstract_time_unit,
   dat_formdate,
   cy_week,
   cy_month,
   currency_iso_cd,
   val_rtl_rl_sfo_store,
   val_rtl_rl_net_sfo_store,
   val_rtl_net_sfo_mhd_break,
   val_rtl_net_sfo_other_stc_loss,
   val_rtl_net_sfo_str_deliv_qlty,
   val_wrtoff_zero_store,
   val_wrtoff_zero_store_net,
   val_wrtoff_zero_store_net_mhd_break,
   val_wrtoff_zero_store_net_other_stc_loss,
   val_wrtoff_zero_store_net_str_deliv_qlty,
   qty_total_sfo_store,
   qty_total_sfo_store_mhd_break,
   qty_total_sfo_store_other_stc_loss,
   qty_total_sfo_store_str_deliv_qlty,
   val_discount_ejr,
   val_discount_net_ejr,
   val_rtl_ejr_adj,
   val_rtl_net_ejr_adj,
   qty_disc_piece_weigth_ejr_asis,
   CAST(COALESCE(COALESCE(val_wrtoff_zero_store, 0) / IF(val_rtl_ejr_adj = 0, NULL, val_rtl_ejr_adj), 0) * 100 AS BIGNUMERIC)
   AS sfo_to_val_retail_pct,
   CAST(COALESCE(COALESCE(val_wrtoff_zero_store_net, 0) / IF(val_rtl_net_ejr_adj = 0, NULL, val_rtl_net_ejr_adj), 0) * 100 AS BIGNUMERIC)
   AS sfo_to_val_retail_net_pct,
   CAST(COALESCE(COALESCE(val_wrtoff_zero_store, 0) / IF(val_rtl_ejr_adj = 0, NULL, val_rtl_ejr_adj), 0) * 100 AS BIGNUMERIC)
   AS wrtoff_zero_to_val_retail_pct,
   CAST(COALESCE(COALESCE(val_wrtoff_zero_store_net, 0) / IF(val_rtl_net_ejr_adj = 0, NULL, val_rtl_net_ejr_adj), 0) * 100 AS BIGNUMERIC)
   AS wrtoff_zero_to_val_retail_net_pct,
   CAST(COALESCE(COALESCE(val_discount_ejr, 0) / IF(val_rtl_ejr_adj = 0, NULL, val_rtl_ejr_adj), 0) * 100 AS BIGNUMERIC)
   AS discount_sfo_to_val_retail_pct,
   CAST(COALESCE(COALESCE(val_discount_net_ejr, 0) / IF(val_rtl_net_ejr_adj = 0, NULL, val_rtl_net_ejr_adj), 0) * 100 AS BIGNUMERIC)
   AS discount_sfo_to_val_retail_net_pct,
    CASE
    WHEN hier_level_fg = 'I' OR hier_level_fg = 'S'
    THEN CAST(val_rtl_net_sfo_mhd_break + val_discount_net_ejr AS BIGNUMERIC)
    ELSE NULL
    END AS val_rtl_net_sfo_mhd_break_discount,
   CAST(COALESCE(CASE
        WHEN hier_level_fg = 'I' OR hier_level_fg = 'S'
        THEN CAST(val_rtl_net_sfo_mhd_break + val_discount_net_ejr AS BIGNUMERIC)
        ELSE NULL
        END, 0) / CASE
       WHEN COALESCE(val_rtl_net_ejr_adj, 0) = 0
       THEN NULL
       ELSE val_rtl_net_ejr_adj
       END * 100 AS BIGNUMERIC) AS sfo_to_val_retail_mhd_break_discount_pct
  FROM ldl_p_lew_mart_msi.v_mat1_bo_base_flop10 AS AG1) AS ag2
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_act AS RCT ON ag2.client_id = RCT.country_id AND ag2.client_id = RCT.language_id
   
 INNER JOIN ldl_p_lew_core_ac.v_location AS OSA ON ag2.client_id = OSA.client_id AND ag2.loc_sid_store = OSA.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LH ON ag2.client_id = LH.client_id AND ag2.loc_sid_store = LH.loc_sid
  AND CURRENT_DATE BETWEEN LH.dwh_valid_from AND LH.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_address AS OSC ON LH.client_id = OSC.client_id AND LH.addr_sid = OSC.addr_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS OWH ON ag2.client_id = OWH.client_id AND ag2.loc_sid_wh = OWH.loc_sid
 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization AS SAM ON ag2.client_id = SAM.client_id AND ag2.loc_sid_store = SAM
    .loc_sid_store AND ag2.loc_sid_wh = SAM.loc_sid_wh;