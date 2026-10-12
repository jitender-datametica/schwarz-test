CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_einkaeufer_grp_int (mandant_id, einkaeufer_grp_id) AS SELECT
 99 AS mandant_id,
 einkaeufer_int_id AS einkaeufer_grp_id
FROM kfl_production_dbp_view.v_in_l_einkaeufer_int;