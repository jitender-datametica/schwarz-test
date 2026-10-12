CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_markant_2 (mandant_id, markant_id) AS SELECT mandant_id,
 markant_id
FROM kfl_production_dbp_view.v_l_markant_2
WHERE mandant_id <> 1;