CREATE OR REPLACE VIEW dbp_msi_view_log.mv_mandant_kunde_spr_zu_2
--27.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage_2

AS
SELECT
v01.mandant_id,
v01.mandant_bez,
v01.mandant_kbez,
v01.mandant_sort_id
FROM dbp_view.v_mandant_2 v01;