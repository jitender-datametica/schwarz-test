create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_VS(
	MANDANT_ID,
	VS_ID,
	VS_BEZ,
	VSVT_BEZ
) as
SELECT 
v01.mandant_id
,v01.vs_id
,v01.vs_bez
,v01.vsvt_bez

FROM dbp_view.v_vs v01
;