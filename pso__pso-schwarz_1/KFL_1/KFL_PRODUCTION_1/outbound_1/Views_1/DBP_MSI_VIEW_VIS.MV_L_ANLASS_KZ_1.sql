CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_anlass_kz_1 AS SELECT DISTINCT '-1' AS anlass_kz,
 'kein definierter Anlass -> Manueller Nachdruck usw.' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'AS' AS anlass_kz,
 'Auslistung' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'MD' AS anlass_kz,
 'Anforderung per MDE-Gerät' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'NA' AS anlass_kz,
 'Neuanlage' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'PE' AS anlass_kz,
 'Preiserhöhung' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'PS' AS anlass_kz,
 'Preissenkung' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'RA_1' AS anlass_kz,
 'Rücksetzung Aktion_1' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'RS_1' AS anlass_kz,
 'Rücksetzung' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'RN' AS anlass_kz,
 'Rücksetzung Neu im Sortiment' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'SA' AS anlass_kz,
 'Sonderaktion / Werbung' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'SO' AS anlass_kz,
 'Sonstiger Anlass' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1
UNION ALL
SELECT DISTINCT 'PX' AS anlass_kz,
 'Textzeilenänderung Plakate' AS beschreibung
FROM kfl_production_dbp_msi_view_vis.mv_mandant_1;