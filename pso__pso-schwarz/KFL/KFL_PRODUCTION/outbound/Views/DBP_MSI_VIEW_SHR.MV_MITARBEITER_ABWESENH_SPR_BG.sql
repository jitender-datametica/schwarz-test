CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiter_abwesenh_spr_bg (mandant_id, abwesenheit_id,
spr_id, abwesenheit_bez) AS SELECT mandant_id,
 abwesenheit_id,
 spr_id,
 abwesenheit_bez
FROM kfl_production_dbp_view.v_mitarbeiter_abwesenh_spr_zu AS V01
WHERE spr_id = 18;