create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_ART_1(
	MANDANT_ID,
	ART_ID,
	KL_ART_ID,
	ZEK_ID,
	ZEK_VAT_ID,
	EIGENMARKE_ID
) as
SELECT
  mandant_id
, art_id
, kl_art_id
, zek_id
, zek_vat_id
, eigenmarke_id

FROM dbp_view.v_art_1 v01;