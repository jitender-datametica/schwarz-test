CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiter_kreis_spr_zu (mandant_id, mitarbeiter_kreis_id,
mitarbeiterkreis_bez) AS SELECT mandant_id,
 mitarbeiter_kreis_id,
 mitarbeiterkreis_bez
FROM kfl_production_dbp_view.v_mitarbeiter_kreis_spr_zu AS v01
WHERE spr_id = 22;