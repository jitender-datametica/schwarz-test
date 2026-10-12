create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WUG(
	MANDANT_ID,
	ARTHIERTYP_ID,
	WG_ID,
	WUG_ID,
	WGI_ID
) as
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
FROM dbp_view.v_wug v01
WHERE v01.arthiertyp_id = 2;