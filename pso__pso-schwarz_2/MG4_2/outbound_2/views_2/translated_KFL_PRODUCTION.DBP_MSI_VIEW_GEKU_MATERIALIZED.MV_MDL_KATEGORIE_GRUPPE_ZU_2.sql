-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_mdl_kategorie_gruppe_zu_2 (kategorie_id,
kategorie_gruppe_id) AS SELECT *
FROM kfl_production_dbp_view.v_mdl_kategorie_gruppe_zu_2 AS v01;