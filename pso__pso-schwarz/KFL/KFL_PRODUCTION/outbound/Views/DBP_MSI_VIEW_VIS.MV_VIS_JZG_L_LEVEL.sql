CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_l_level (level_id, level_bez, level_bez_cz,
level_bez_sk, level_bez_hr, level_bez_pl, level_bez_ro, level_bez_bg, level2_bez, level2_bez_cz, level2_bez_sk,
level2_bez_hr, level2_bez_pl, level2_bez_ro, level2_bez_bg) AS SELECT CAST(0 AS BIGNUMERIC) AS level_id,
 CAST('Gesamt' AS STRING) AS level_bez,
 CAST('Celkem' AS STRING) AS level_bez_cz,
 CAST('Celkom' AS STRING) AS level_bez_sk,
 CAST('Ukupno' AS STRING) AS level_bez_hr,
 CAST('Razem' AS STRING) AS level_bez_pl,
 CAST('Total' AS STRING) AS level_bez_ro,
 CAST('Общо' AS STRING) AS level_bez_bg,
 'Filiale Gesamt' AS level2_bez,
 'Filiálka Celkem' AS level2_bez_cz,
 'Filiálka Celkem' AS level2_bez_sk,
 'Filiálka Celkom' AS level2_bez_hr,
 'Filiálka Celkem' AS level2_bez_pl,
 'Filiálka Celkem' AS level2_bez_ro,
 'Filiálka Celkem' AS level2_bez_bg
FROM (SELECT 0,
    'Gesamt',
    'Celkem',
    'Celkom',
    'Ukupno',
    'Razem',
    'Total',
    'Общо',
    'Filiale Gesamt',
    'Filiálka Celkem',
    'Filiálka Celkom',
    'Poslovnica Ukupno',
    'Market Razem',
    'Magazin Total',
    'Филиал Общо'
   UNION ALL
   SELECT CASE
     WHEN ABT.abt_id = 4
     THEN 9999999
     ELSE ABT.abt_id * 1000000
     END,
    ABTS.abt_bez,
    ABTS.abt_bez_cz,
    ABTS.abt_bez_sk,
    ABTS.abt_bez_hr,
    ABTS.abt_bez_pl,
    ABTS.abt_bez_ro,
    ABTS.abt_bez_bg,
     'Abteilung ' || ABTS.abt_bez,
     'Oddělení ' || ABTS.abt_bez_cz,
     'Oddelenie' || ABTS.abt_bez_sk,
     'Odjel' || ABTS.abt_bez_hr,
     'Dział' || ABTS.abt_bez_pl,
     'Departament' || ABTS.abt_bez_ro,
     'Отдел' || ABTS.abt_bez_bg
   FROM kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int_spr_zu AS ABTS ON ABT.abt_id = ABTS.abt_id
   WHERE ABT.abt_id IN (4, 5, 6, 7, 8)
   UNION ALL
   SELECT ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000,
    HWGS.hwg_bez,
    HWGS.hwg_bez_cz,
    HWGS.hwg_bez_sk,
    HWGS.hwg_bez_hr,
    HWGS.hwg_bez_pl,
    HWGS.hwg_bez_ro,
    HWGS.hwg_bez_bg,
     'HWG' || HWGS.hwg_bez,
     'HWG' || HWGS.hwg_bez_cz,
     'HWG' || HWGS.hwg_bez_sk,
     'HWG' || HWGS.hwg_bez_hr,
     'GGT' || HWGS.hwg_bez_pl,
     'HWG' || HWGS.hwg_bez_ro,
     'HWG' || HWGS.hwg_bez_bg
   FROM kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_spr_zu AS HWGS ON HWG.hwg_id = HWGS.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT ON HWG.abt_id = ABT.abt_id
   WHERE ABT.abt_id IN (5, 6)
    AND HWG.hwg_id > 0
   UNION ALL
   SELECT ABT.abt_id * 1000000 + ABS(HWG.hwg_id) * 10000 + ABS(OWG.owg_id),
    OWGS.owg_bez,
    OWGS.owg_bez_cz,
    OWGS.owg_bez_sk,
    OWGS.owg_bez_hr,
    OWGS.owg_bez_pl,
    OWGS.owg_bez_ro,
    OWGS.owg_bez_bg,
     'OWG' || OWGS.owg_bez,
     'OWG' || OWGS.owg_bez_cz,
     'OWG' || OWGS.owg_bez_sk,
     'OWG' || OWGS.owg_bez_hr,
     'NGT' || OWGS.owg_bez_pl,
     'OWG' || OWGS.owg_bez_ro,
     'OWG' || OWGS.owg_bez_bg
   FROM kfl_production_dbp_msi_view_vis.mv_owg_int AS OWG
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_spr_zu AS OWGS ON OWG.owg_id = OWGS.owg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int AS HWG ON OWG.hwg_id = HWG.hwg_id
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_int AS ABT ON HWG.abt_id = ABT.abt_id
   WHERE ABT.abt_id IN (5)
    AND OWG.owg_id > 0) AS jzg;