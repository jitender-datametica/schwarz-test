CREATE OR REPLACE VIEW dbp_msi_view_log.mv_hwg_per -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 hwg_id
,abt_id
,arthiertyp_id
)
AS
SELECT DISTINCT
v01.hwg_id,
v01.abt_id,
v01.arthiertyp_id
FROM dbp_view.v_hwg_per v01
WHERE v01.arthiertyp_id = 2
AND v01.dat_bis = to_date('9999-12-31', 'YYYY-MM-DD');
