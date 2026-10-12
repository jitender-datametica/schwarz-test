CREATE OR REPLACE VIEW dbp_msi_view_log.mv_mandant_wrg_typ_zu_2
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 mandant_id
,wrg_id
,wrg_typ_id
,wrg_typ_bez
)
AS
SELECT
v01.mandant_id,
v01.wrg_id,
v01.wrg_typ_id,
v01.wrg_typ_bez
FROM dbp_view.v_mandant_wrg_typ_zu_2 v01;