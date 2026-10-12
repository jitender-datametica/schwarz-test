CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_personalbereich_zu_per_2 (mandant_id, system_id,
buchungskreis_id, mitarbeiter_id, kjmo) AS SELECT mandant_id,
 system_id,
 buchungskreis_id,
 mitarbeiter_id,
 kjmo
FROM kfl_production_dbp_view.v_ma_personalbereich_zu_per_2;