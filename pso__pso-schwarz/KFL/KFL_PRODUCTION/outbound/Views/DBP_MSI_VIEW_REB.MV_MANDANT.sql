CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_mandant (mandant_id, mandant_bez, mandant_kbez) AS SELECT
 mandant_id,
 mandant_bez,
 mandant_kbez
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;