create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_ARTIKEL_1(
	GEKU_ARTIKEL_UID,
	GEKU_ARTIKEL_ID,
	GEKU_GRUND_UID,
	LAND_ISO,
	GEKU_DWH_ARTIKEL_ID,
	KMR_QUELLE_ID,
	AKTIV_FG
) as
-- 30.03.2015 twie: neues aktiv_fg, da mit Einführung neuer Kategorienbaum alte Kategorien deaktiviert werden
-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_1 um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

   SELECT
   geku_artikel_uid
   , geku_artikel_id
   , geku_grund_uid
   , land_iso
   , geku_dwh_artikel_id
   , 3 AS kmr_quelle_id
   , aktiv_fg
   FROM dbp_view.v_l_geku_artikel_1;