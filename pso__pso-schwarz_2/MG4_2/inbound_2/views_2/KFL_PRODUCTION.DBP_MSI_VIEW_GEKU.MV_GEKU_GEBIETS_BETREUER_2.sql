create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_GEBIETS_BETREUER_2(
	GEBIETS_BETREUER_UID,
	FV_FG,
	FV_GB_ID,
	GBB_NAME,
	GBB_VORNAME,
	GBB_ANREDE,
	GBB_STRASSE,
	GBB_PLZ,
	GBB_ORT,
	GBB_LAND_ID,
	MANDANT_ID,
	GBB_EMAIL,
	GBB_TEL_MOBIL,
	GBB_TELEFON,
	GBB_FAX
) as
   SELECT
   gebiets_betreuer_uid
   , fv_fg
   , fv_gb_id
   , gbb_name
   , gbb_vorname
   , gbb_anrede
   , gbb_strasse
   , gbb_plz
   , gbb_ort
   , gbb_land_id
   , mandant_id
   , gbb_email
   , gbb_tel_mobil
   , gbb_telefon
   , gbb_fax
   FROM dbp_view.v_geku_gebiets_betreuer_2;