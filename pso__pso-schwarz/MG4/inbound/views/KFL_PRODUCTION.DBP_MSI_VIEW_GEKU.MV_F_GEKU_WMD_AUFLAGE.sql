create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_F_GEKU_WMD_AUFLAGE(
	WMD_AUSTRAEGER_GEBIET_UID,
	DAT,
	MANDANT_ID,
	KDC_FG,
	MZK_FG,
	WMD_FG,
	SEC_KZ,
	AUFLAGE
) as
-- 16.07.2012 twie: Umstellung auf Tabelle mit historisierter Auflage
-- 21.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter
-- 12.10.2022 twie: SPEC0167837 sek_kz von 3 auf 3 geändert

   SELECT
   a17.wmd_austraeger_gebiet_uid
   , a17.dat
   , a18.mandant_id
   , 0::BYTEINT         KDC_fg
   , 0::BYTEINT         MZK_fg
   , 1::BYTEINT         WMD_fg
   , 3::BYTEINT AS sec_kz
   , a17.auflage

   FROM dbp_view.v_geku_ges_vertriebsltg a11

   JOIN dbp_view.v_geku_vertriebsbuero a12
   ON  (a11.country_uid = a12.country_uid)

   JOIN dbp_view.v_geku_gebietsleiter a13
   ON  (a12.vertriebsbuero_uid = a13.vertriebsbuero_uid)

   JOIN dbp_view.v_geku_verteilgebiet a14
   ON  (a13.gebietsleiter_uid = a14.gebietsleiter_uid)

   JOIN dbp_view.v_geku_gebiets_bereich a15
   ON  (a14.verteilgebiet_uid = a15.verteilgebiet_uid)

   JOIN dbp_view.v_geku_austr_gebiet a16
   ON  (a15.gebiets_bereich_uid = a16.gebiets_bereich_uid)

   JOIN dbp_view.v_geku_austr_gebiet_tag a17
   ON  (a16.wmd_austraeger_gebiet_uid = a17.wmd_austraeger_gebiet_uid)

   JOIN dbp_view.v_mandant a18
   ON  (a11.land_iso = CASE WHEN a18.mandant_kbez = 'D' THEN 'DE' ELSE a18.mandant_kbez END);