CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_personalbereich_zu_per_1 (system_id, mandant_id, buchungskreis_id,
mitarbeiter_id, kjmo) AS SELECT system_id,
 mandant_id,
 buchungskreis_id,
 mitarbeiter_id,
 kjmo
FROM kfl_production_dbp_data.ma_personalbereich_zu_per_1;