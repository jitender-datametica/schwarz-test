CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WUG_2
(
  mandant_id
, arthiertyp_id
, wg_id
, wug_id
, wgi_id
)
AS
SELECT
v01.mandant_id
,v01.arthiertyp_id
,v01.wg_id
,v01.wug_id
,CASE
WHEN v01.wg_id < 0 THEN '-' || CAST((v01.wg_id) AS CHAR(3))
ELSE CAST((v01.wg_id) AS CHAR(3)) END || CASE
WHEN v01.wug_id < 0 THEN '-' || CAST((v01.wug_id) AS CHAR(3))
ELSE CAST((v01.wug_id) AS CHAR(3)) END AS wgi_id
FROM dbp_view.v_wug_2 v01
WHERE v01.arthiertyp_id = 2;