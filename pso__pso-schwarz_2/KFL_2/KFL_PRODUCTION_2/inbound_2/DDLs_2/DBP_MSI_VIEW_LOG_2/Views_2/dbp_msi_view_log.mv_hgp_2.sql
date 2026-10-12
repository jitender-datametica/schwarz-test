CREATE OR REPLACE VIEW dbp_msi_view_log.mv_hgp_2 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 hgp_id
,hgp_name
,mandant_id
,zek_id
,einkaufsorganisation_id
)
AS
SELECT
DISTINCT v01.gp_id,
v01.gp_name,
v01.mandant_id,
v01.zek_id,
v01.einkaufsorganisation_id
FROM dbp_view.v_gp_2 v01
WHERE v01.gp_id IN (SELECT
CASE
WHEN v02.hgp_id = -1 OR v02.hgp_id IS NULL THEN v02.gp_id
ELSE v02.hgp_id END
FROM dbp_view.v_gp_2 v02
);
