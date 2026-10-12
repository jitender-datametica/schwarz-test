CREATE OR REPLACE VIEW dbp_msi_view_log.mv_wug_1 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
(
 arthiertyp_id
,wug_id
,wg_id
)
AS
SELECT
v01.arthiertyp_id,
v01.wug_id,
v01.wg_id
FROM dbp_view.v_wug_1 v01
WHERE arthiertyp_id = 2
GROUP BY v01.arthiertyp_id
        ,v01.wug_id
        ,v01.wg_id;
