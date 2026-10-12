CREATE OR REPLACE VIEW dbp_msi_view_log.mv_quartal_gj
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 gjqu
,akt_gjqu
,akt_gjqu_komplett
,gj
,akt_gj
,akt_gj_komplett
)
AS
SELECT
v01.gjqu,
v01.akt_gjqu,
v01.akt_gjqu_komplett,
v01.gj,
v01.akt_gj,
v01.akt_gj_komplett
FROM dbp_view.v_quartal_gj v01
WHERE v01.gjqu > 200104;