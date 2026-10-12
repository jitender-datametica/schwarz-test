create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_EK_HIERARCHIE_1(
	MANDANT_ID,
	ZEK_ID,
	ZEK_NAME,
	WBL_ID,
	WBL_NAME,
	GF_ID,
	GF_NAME
) as
SELECT
  v01.mandant_id
, v01.zek_id
, v01.zek_name
, v01.wbl_id
, v02.wbl_name
, v02.gf_id
, v03.gf_name

FROM dbp_view.v_zek_1 v01

INNER JOIN dbp_view.v_wbl_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.wbl_id = v02.wbl_id

INNER JOIN dbp_view.v_gf_1 v03
ON v02.mandant_id = v03.mandant_id
AND v02.gf_id = v03.gf_id;