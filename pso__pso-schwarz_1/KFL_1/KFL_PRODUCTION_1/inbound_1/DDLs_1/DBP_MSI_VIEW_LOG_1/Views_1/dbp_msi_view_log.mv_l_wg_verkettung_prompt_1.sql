CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_wg_verkettung_prompt_1 --29.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage_1

AS
SELECT
v01.wg_verkett_id
FROM dbp_view.v_l_wg_verkettung_1 v01;
