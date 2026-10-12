CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_FUNKTIONSAENDERUNG_SPR_ZU_1 as
   SELECT t.*
   FROM (SELECT * FROM (SELECT '2' AS shr_ma_funktionaenderung_id, 'Keine Änderung' AS shr_ma_funktionaenderung_bez) x
   UNION ALL
   SELECT * FROM (SELECT '1' AS shr_ma_funktionaenderung_id, 'Rückstufung' AS shr_ma_funktionaenderung_bez) x
   UNION ALL
   SELECT * FROM (SELECT '3' AS shr_ma_funktionaenderung_id, 'Beförderung' AS shr_ma_funktionaenderung_bez) x
   ) t;