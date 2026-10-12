CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_lieferant_int_2 (in_lief_id_int, lief_name) AS SELECT
 in_lief_id_int,
 lief_name
FROM kfl_production_dbp_view.v_in_lieferant_int_2 AS V01;