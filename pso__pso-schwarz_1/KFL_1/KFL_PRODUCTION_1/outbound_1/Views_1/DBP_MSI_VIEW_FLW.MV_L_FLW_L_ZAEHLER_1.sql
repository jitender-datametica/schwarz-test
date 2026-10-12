CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_zaehler_1 (mandant_id, zaehler_id, zaehlerart) AS SELECT
 mandant_id,
 zaehler_id,
 TRIM(zaehlerart) AS zaehlerart
FROM kfl_production_dbp_view.v_flw_l_zaehler_1 AS V01;