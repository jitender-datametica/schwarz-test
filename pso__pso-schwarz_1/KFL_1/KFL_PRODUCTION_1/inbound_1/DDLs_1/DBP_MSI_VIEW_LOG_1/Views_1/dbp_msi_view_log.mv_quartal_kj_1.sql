CREATE OR REPLACE VIEW dbp_msi_view_log.mv_quartal_kj_1
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 kjqu
,akt_kjqu
,akt_kjqu_komplett
,kj
,akt_kj
,akt_kj_komplett
)
AS
SELECT
v01.kjqu,
v01.akt_kjqu,
v01.akt_kjqu_komplett,
v01.kj,
v01.akt_kj,
v01.akt_kj_komplett
FROM dbp_view.v_quartal_kj_1 v01
WHERE v01.kjqu > 200104;