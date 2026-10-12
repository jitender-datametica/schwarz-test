-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_kategorie_gruppe_zu (kategorie_id,
kategorie_gruppe_id) AS SELECT kategorie_id,
 kategorie_gruppe_id
FROM dbp_view.v_mdl_kategorie_gruppe_zu AS V01;