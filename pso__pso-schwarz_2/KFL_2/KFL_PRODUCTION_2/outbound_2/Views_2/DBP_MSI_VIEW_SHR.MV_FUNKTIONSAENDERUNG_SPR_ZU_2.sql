CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_funktionsaenderung_spr_zu_2 AS SELECT
 shr_ma_funktionaenderung_id,
 shr_ma_funktionaenderung_bez
FROM (SELECT '2' AS shr_ma_funktionaenderung_id,
    'Keine Änderung' AS shr_ma_funktionaenderung_bez
   UNION ALL
   SELECT '1' AS shr_ma_funktionaenderung_id,
    'Rückstufung' AS shr_ma_funktionaenderung_bez
   UNION ALL
   SELECT '3' AS shr_ma_funktionaenderung_id,
    'Beförderung' AS shr_ma_funktionaenderung_bez);