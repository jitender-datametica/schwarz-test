CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_platzierungsstufe_1 (mandant_id, platzierungsstufe_id,
sk_id_apollo) AS SELECT mandant_id,
 platzierungsstufe_id,
 sk_id_apollo
FROM kfl_production_dbp_view.v_l_platzierungsstufe_1
WHERE mandant_id = 1
 AND (SUBSTR(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z', 'V') OR CAST(SUBSTR(platzierungsstufe_id, 3, 1) AS FLOAT64)
     = 0 AND SUBSTR(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z', 'V'));