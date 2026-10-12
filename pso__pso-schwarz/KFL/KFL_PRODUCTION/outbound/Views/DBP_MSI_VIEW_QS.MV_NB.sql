CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_nb (nb_id, nb_bez) AS SELECT nb_id,
 nb_bez
FROM kfl_production_dbp_view.v_nb AS V01;