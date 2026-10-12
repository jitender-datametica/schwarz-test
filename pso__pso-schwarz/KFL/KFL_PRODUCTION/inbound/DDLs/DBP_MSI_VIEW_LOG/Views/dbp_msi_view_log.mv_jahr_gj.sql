CREATE OR REPLACE VIEW dbp_msi_view_log.mv_jahr_gj -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 gj
,akt_gj
,akt_gj_komplett
)
AS
SELECT
v01.gj,
v01.akt_gj,
v01.akt_gj_komplett
FROM dbp_view.v_jahr_gj v01
WHERE v01.gj > 2003;
