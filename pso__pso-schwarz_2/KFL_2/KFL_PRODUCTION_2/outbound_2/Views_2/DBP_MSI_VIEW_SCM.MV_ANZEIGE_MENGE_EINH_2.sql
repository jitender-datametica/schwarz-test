CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_anzeige_menge_einh_2 AS SELECT 'BME' AS anzeige_menge_einh_id,
 'Basismengeneinheit (ST oder KG)' AS anzeige_menge_einh_bez
UNION ALL
SELECT 'ST' AS anzeige_menge_einh_id,
 'Stück' AS anzeige_menge_einh_bez
UNION ALL
SELECT 'KG' AS anzeige_menge_einh_id,
 'Kilogramm' AS anzeige_menge_einh_bez
UNION ALL
SELECT 'EUR' AS anzeige_menge_einh_id,
 'VK_2-Brutto' AS anzeige_menge_einh_bez
UNION ALL
SELECT 'KOL' AS anzeige_menge_einh_id,
 'Kolli' AS anzeige_menge_einh_bez;