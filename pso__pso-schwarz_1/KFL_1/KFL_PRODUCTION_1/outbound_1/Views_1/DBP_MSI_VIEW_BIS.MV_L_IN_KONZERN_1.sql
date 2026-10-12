CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_konzern_1 (mandant_id, konzern_id, konzern_name) AS SELECT
 mandant_id,
 konzern_id,
 konzern_name
FROM kfl_production_dbp_view.v_in_l_konzern_1;