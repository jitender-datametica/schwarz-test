CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WUG_1(
	MANDANT_ID,
	WG_ID,
	WUG_ID,
	WGI_ID
) AS SELECT
    v01.mandant_id
    ,v01.wg_id
    ,v01.wug_id
    ,CASE WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
    ELSE TO_VARCHAR(v01.wg_id, 'FM000') END ||
    CASE WHEN v01.wug_id < 0 THEN TO_VARCHAR(v01.wug_id, 'FM000')
    ELSE TO_VARCHAR(v01.wug_id, 'FM000') END AS wgi_id
FROM dbp_view.v_wug_1 v01;