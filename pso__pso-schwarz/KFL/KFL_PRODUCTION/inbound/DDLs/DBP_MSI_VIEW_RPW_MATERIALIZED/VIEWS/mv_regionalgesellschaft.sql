create or replace view DBP_MSI_VIEW_RPW_MATERIALIZED.MV_REGIONALGESELLSCHAFT(
	VS_ID,
	VS_BEZ,
	VSVT_BEZ
) as
--07.09.2023, prescherad, SPEC0211574, einfügen Gesellschaft 0 als Dummywert
SELECT
v01.vs_id
,v02.vs_bez
,v02.vsvt_bez
 
FROM dbp_view.v_wup v01
INNER JOIN dbp_view.v_vs v02
 
ON v01.mandant_id = v02.mandant_id
AND v01.vs_id = v02.vs_id
AND v01.mandant_id = 1
AND v02.vk_id = 1
GROUP BY 3,2,1
UNION ALL 
SELECT
'0' AS vs_id,
'Keine' AS vs_bez,
'Keine Regionalgesellschaft' AS vsvt_bez
FROM dbp_view.v_vs v1
WHERE MANDANT_ID=1
AND VK_ID =0;