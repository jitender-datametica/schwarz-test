CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiter_abwesenh_spr_1 (mandant_id, abwesenheit_id, spr_id,
abwesenheit_bez) AS SELECT *
FROM kfl_production_dbp_view.v_mitarbeiter_abwesenh_spr_zu_1 AS v01
WHERE spr_id = 22;