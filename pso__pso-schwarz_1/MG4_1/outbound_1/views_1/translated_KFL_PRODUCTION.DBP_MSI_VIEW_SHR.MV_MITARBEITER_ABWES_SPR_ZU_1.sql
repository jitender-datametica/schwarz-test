CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiter_abwes_spr_zu_1 (mandant_id, abwesenheit_id,
abwesenheit_bez) AS SELECT mandant_id,
 abwesenheit_id,
 abwesenheit_bez
FROM kfl_production_dbp_view.v_mitarbeiter_abwesenh_spr_zu_1 AS v01
WHERE spr_id = 22;