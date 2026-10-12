CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_instandhaltung_leistungsart_spr_zu (instandhaltung_leistungsart_id
, instandhaltung_leistungsart_bez) AS SELECT instandhaltung_leistungsart_id,
 instandhaltung_leistungsart_bez
FROM kfl_production_dbp_view.v_in_instandhaltung_leistungsart_spr_zu AS V01
WHERE spr_id = 22
 AND mandant_id = 1
 AND instandhaltung_leistungsart_id NOT IN ('061', '062', '063', '064')
UNION DISTINCT
SELECT instandhaltung_leistungsart_id,
 instandhaltung_leistungsart_bez
FROM kfl_production_dbp_view.v_in_instandhaltung_leistungsart_spr_zu AS V01
WHERE spr_id = 22
 AND mandant_id = 6
 AND instandhaltung_leistungsart_id IN ('061', '062', '063', '064');