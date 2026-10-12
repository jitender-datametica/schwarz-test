create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_DWH_ARTIKEL_1(
	GEKU_DWH_ARTIKEL_ID,
	KMR_QUELLE_ID,
	GEKU_GRUND_UID,
	GEKU_ARTIKEL_UID,
	GEKU_ARTIKEL_ID,
	WMD_FG,
	AKTIV_FG,
	ALT_FG,
	FIPO_PRUEFPUNKT_ID,
	KMR_QUELLE_PP_ID,
	GEKU_KMR_FG
) as
-- 30.03.2015 twie: neues aktiv_fg, da mit Einführung neuer Kategorienbaum alte Kategorien deaktiviert werden
-- 09.09.2015 twie: Lookup für DWH Artikel_1 (3. Ebene)
-- Filterung über Artikel_1 (4. Ebene) damit für DWH Artikel_1 keine Elemente angezeigt werden
-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)
-- 16.11.2015 twie: alt_fg (Kennzeichnet alle Elemente aus altem Kategoriebaum vor Umstellung am 1.8.15)
-- 06.03.2017 twie: SPEC0021069 fipo_pruefpunkt_id als Verbindung zu K-VISIT (jeder DWH Artikel_1 an genau einem Prüfpunkt)
-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_1 um kmr_quelle_id ergänzg für Zusammenführung Hierarchie
-- 14.06.2018 twie: SPEC0038139 Schlüssel für Prüfpunkt um kmr_quelle_id ergänzt für Zusammenführung Hierarchie
-- 22.11.2018 twie: SPEC0046551 neues Flag für DHW Artikel_1, die auf KMR Hierarchie gemappt sind

   SELECT
   v01.geku_dwh_artikel_id
   , 3 AS kmr_quelle_id
   , v01.geku_grund_uid
   , v01.geku_artikel_uid
   , v01.geku_artikel_id
   , v01.WMD_fg
   , v01.aktiv_fg
   , v01.alt_fg
   , v01.fipo_pruefpunkt_id
   , 4 AS kmr_quelle_pp_id
   , CASE WHEN v02.kmr_agm_id IS NULL THEN 0 ELSE 1 END AS geku_kmr_fg

   FROM dbp_view.v_l_geku_dwh_artikel_1 v01
   
   LEFT OUTER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_1 v02
   ON v01.geku_dwh_artikel_id = v02.kmr_agm_id
   AND v02.kmr_quelle_id = 3

   WHERE v01.geku_dwh_artikel_id IN
   (SELECT geku_dwh_artikel_id FROM dbp_view.v_l_geku_artikel_1);