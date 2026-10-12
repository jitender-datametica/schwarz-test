CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_datumsart_zu_per_2 (mandant_id, datumsart_id, mitarbeiter_id
, kjmo, dat_von) AS SELECT mandant_id,
 datumsart_id,
 mitarbeiter_id,
 kjmo,
 dat_von
FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS v01;