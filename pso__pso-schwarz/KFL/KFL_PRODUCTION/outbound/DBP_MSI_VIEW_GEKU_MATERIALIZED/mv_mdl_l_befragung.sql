-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_l_befragung (befragung_id) AS SELECT
 befragung_id
FROM dbp_view.v_mdl_l_befragung AS V01;