CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_wg_verkettung_2 --28.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage_2

AS
SELECT
v01.mandant_id,
v01.wg_verkett_id
FROM dbp_view.v_l_wg_verkettung_2 v01;
