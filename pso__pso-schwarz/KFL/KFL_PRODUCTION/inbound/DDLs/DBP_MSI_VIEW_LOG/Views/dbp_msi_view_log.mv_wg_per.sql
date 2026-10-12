CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wg_per
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
-- 24.03.2020, AP0053509, SPEC0071753, mcie1607, removed lead_mwst_id
-- 23.03.2021, intern, srom0404, Abgrenzung arthiertyp und dat_bis
(
 wg_id
,arthiertyp_id
,abt_id
,owg_id
)
AS
SELECT DISTINCT
v01.wg_id,
v01.arthiertyp_id,
v01.abt_id,
v01.owg_id
FROM dbp_view.v_wg_per v01
WHERE v01.arthiertyp_id = 2
AND v01.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD')
;