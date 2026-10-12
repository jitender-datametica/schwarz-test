CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_platzierungsstufe_spr_zu_2 (mandant_id, platzierungsstufe_id,
spr_id, platzierungsstufe_bez) AS SELECT mandant_id,
 platzierungsstufe_id,
 spr_id,
 platzierungsstufe_bez
FROM kfl_production_dbp_view.v_platzierungsstufe_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22
 AND (SUBSTR(platzierungsstufe_id, 1, 1) IN ('X', 'Y', 'Z') OR CAST(SUBSTR(platzierungsstufe_id, 3, 1) AS FLOAT64) = 0
    AND SUBSTR(platzierungsstufe_id, 1, 1) NOT IN ('X', 'Y', 'Z'));