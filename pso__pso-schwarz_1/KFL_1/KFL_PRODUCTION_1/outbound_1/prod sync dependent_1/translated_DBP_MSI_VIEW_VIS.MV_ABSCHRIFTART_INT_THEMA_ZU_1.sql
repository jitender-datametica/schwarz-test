-- LOOKUP/ZUORDNUNG Abschriftart INTEGER  - Abschriftart INTEGER Thema
 -- 2017-0221 : Initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_1 (abschriftart_int_id,
abschriftart_thema_int_id) AS SELECT abschriftart_int_id,
 abschriftart_thema_int_id
FROM kfl_production_dbp_view.v_l_abschriftart_int_1 AS AITZ;