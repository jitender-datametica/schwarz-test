create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_GF_1(
	GF_ID,
	GF_NAME,
	MANDANT_ID,
	EK_FG
) as 
SELECT
gf_id
, gf_name
, mandant_id
,ek_fg
FROM dbp_view.v_gf_1
;