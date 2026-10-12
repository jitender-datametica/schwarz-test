create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_AUSTR_GEBIET(
	WMD_AUSTRAEGER_GEBIET_UID,
	GEBIETS_BEREICH_UID,
	AUFLAGE,
	SOLO_FG,
	WMD_AUSTR_GEBIET_BEZ,
	AUSTR_GEBIET_LFD_NR
) as
   SELECT
   wmd_austraeger_gebiet_uid
   , gebiets_bereich_uid
   , auflage
   , solo_fg
   , wmd_austr_gebiet_bez
   , austr_gebiet_lfd_nr
   FROM dbp_view.v_geku_austr_gebiet;