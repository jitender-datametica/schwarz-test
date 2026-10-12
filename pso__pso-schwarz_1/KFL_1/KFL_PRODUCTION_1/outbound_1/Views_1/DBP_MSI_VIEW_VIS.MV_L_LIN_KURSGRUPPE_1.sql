CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_lin_kursgruppe_1 (mandant_id, lin_kursgruppe_id) AS SELECT
 mandant_id,
 lin_kursgruppe_id
FROM kfl_production_dbp_view.v_l_lin_kursgruppe_1;