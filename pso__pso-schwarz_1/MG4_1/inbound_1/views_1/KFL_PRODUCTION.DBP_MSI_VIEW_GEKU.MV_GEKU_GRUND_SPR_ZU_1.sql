create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_GRUND_SPR_ZU_1(
	GEKU_GRUND_UID,
	GEKU_GRUND_BEZ,
	GEKU_GRUND_BEZ_CZ,
	GEKU_GRUND_BEZ_PL,
	GEKU_GRUND_BEZ_SK,
	GEKU_GRUND_BEZ_HR,
	GEKU_GRUND_BEZ_RO,
	GEKU_GRUND_BEZ_BG
) as
-- 09.09.2015 twie: Sprachview für Grund (2. Ebene)
-- Filterung über DWH Artikel_1 (3. Ebene) damit für Grund keine Elemente angezeigt werden
-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)
-- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_grund_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_grund_bez ELSE NULL END)  AS geku_grund_bez_bg

   FROM dbp_view.v_geku_grund_spr_zu_1 v01

   WHERE v01.geku_grund_uid IN
   (SELECT geku_grund_uid FROM dbp_view.v_l_geku_dwh_artikel_1)

   GROUP BY v01.geku_grund_uid;