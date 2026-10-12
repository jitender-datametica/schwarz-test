create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_GRUND_1(
	GEKU_GRUND_UID,
	GEKU_GRUND_ID,
	GEKU_BEREICH_UID
) as
-- 09.09.2015 twie: Lookup für Grund (2. Ebene)
-- Filterung über DWH Artikel_1 (3. Ebene) damit für Grund keine Elemente angezeigt werden
-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)

   SELECT
   geku_grund_uid
   , geku_grund_id
   , geku_bereich_uid
   FROM dbp_view.v_l_geku_grund_1

   WHERE geku_grund_uid IN
   (SELECT geku_grund_uid FROM dbp_view.v_l_geku_dwh_artikel_1);