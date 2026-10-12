CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_nb_2 (nb_id, nb_bez, system_id) AS SELECT nb_id,
 nb_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_nb_2
WHERE nb_id IN (- 111, 0, 2, 99);