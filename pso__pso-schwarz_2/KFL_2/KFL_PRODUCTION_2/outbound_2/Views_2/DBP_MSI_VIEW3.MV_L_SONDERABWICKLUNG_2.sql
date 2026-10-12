CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_sonderabwicklung_2 (mandant_id, sonderabwicklung_id) AS SELECT
 mandant_id,
 sonderabwicklung_id
FROM kfl_production_dbp_view.v_l_sonderabwicklung_2;