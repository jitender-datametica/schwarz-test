CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_INVENTUR_DIFF_1(
      kjmo
      ,mandant_id
      ,wup_id
      ,wg_id
      ,arthiertyp_id
      ,custom_1_id
      ,custom_2_id
      ,custom_3_id
      ,custom_4_id
      ,ums_brutto_ist_hfm
      ,betrag_inv_diff_brutto_hfm
      ,ums_brutto_plan_hfm
      ,betrag_inv_diff_plan_hfm
      ,menge_end_bestand_hfm
      ,bestand_berechnet_fg
      ,betrag_abschr_brutto_hfm
) AS
SELECT
      kjmo
      , mandant_id
      , wup_id
      , wg_id
      , arthiertyp_id
      , custom_1_id
      , custom_2_id
      , custom_3_id
      , custom_4_id
      , ums_brutto_ist_hfm
      , betrag_inv_diff_brutto_hfm
      , CASE 
         WHEN SUM(ums_brutto_ist_hfm) OVER (PARTITION BY mandant_id, wup_id, wg_id, kjmo) IS NOT NULL 
         THEN ums_brutto_plan_hfm END AS ums_brutto_plan_hfm
      , CASE 
         WHEN SUM(ums_brutto_ist_hfm) OVER (PARTITION BY mandant_id, wup_id, wg_id, kjmo) IS NOT NULL 
         THEN betrag_inv_diff_plan_hfm END AS betrag_inv_diff_plan_hfm
      , CASE 
         WHEN SUM(ums_brutto_ist_hfm) OVER (PARTITION BY mandant_id, wup_id, wg_id, kjmo) IS NOT NULL 
         THEN menge_end_bestand_hfm END AS menge_end_bestand_hfm
      , CASE 
         WHEN menge_end_bestand_hfm IS NOT NULL AND SUM(ums_brutto_ist_hfm) OVER (PARTITION BY mandant_id, wup_id, wg_id, kjmo) IS NOT NULL 
         THEN bestand_berechnet_fg ELSE NULL END AS bestand_berechnet_fg
      , betrag_abschr_brutto_hfm
FROM dbp_view.v_vis_monat_inventur_diff_1
WHERE custom_3_id <> 'VK_SYS_IN';