CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_mdl_frage_antwort_zu
-- 27.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
-- 14.12.2020 AP0066293, SPEC0096572 Pawel Staniszewski, additional nok_fg
AS
SELECT
v01.frage_id,
v01.antwort_id,
v01.nok_fg
FROM dbp_view.v_mdl_frage_antwort_zu v01;