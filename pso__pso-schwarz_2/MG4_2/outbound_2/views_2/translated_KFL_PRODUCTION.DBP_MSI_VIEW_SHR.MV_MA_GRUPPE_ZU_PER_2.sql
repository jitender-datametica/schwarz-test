CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_gruppe_zu_per_2 (mandant_id, mitarbeiter_gruppe_id,
mitarbeiter_id, kjmo) AS SELECT mandant_id,
 mitarbeiter_gruppe_id,
 mitarbeiter_id,
 kjmo
FROM kfl_production_dbp_view.v_ma_gruppe_zu_per_2 AS v01;