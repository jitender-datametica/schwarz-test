CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_l_lin_kursgruppe (mandant_id, lin_kursgruppe_id) AS SELECT
 mandant_id,
 lin_kursgruppe_id
FROM kfl_production_dbp_view.v_l_lin_kursgruppe;