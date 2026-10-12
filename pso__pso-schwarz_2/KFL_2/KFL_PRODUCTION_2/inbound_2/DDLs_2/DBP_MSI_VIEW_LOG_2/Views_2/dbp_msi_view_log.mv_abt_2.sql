CREATE OR REPLACE VIEW dbp_msi_view_log.mv_abt_2  -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 abt_id
,arthiertyp_id
)
AS
SELECT
v01.abt_id,
v01.arthiertyp_id
FROM dbp_view.v_abt_2 v01
WHERE v01.arthiertyp_id = 2;
