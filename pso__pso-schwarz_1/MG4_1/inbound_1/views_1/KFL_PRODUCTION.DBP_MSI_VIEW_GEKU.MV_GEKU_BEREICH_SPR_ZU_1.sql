create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_BEREICH_SPR_ZU_1(
	GEKU_BEREICH_UID,
	GEKU_BEREICH_BEZ,
	GEKU_BEREICH_BEZ_CZ,
	GEKU_BEREICH_BEZ_PL,
	GEKU_BEREICH_BEZ_SK,
	GEKU_BEREICH_BEZ_HR,
	GEKU_BEREICH_BEZ_RO,
	GEKU_BEREICH_BEZ_BG
) as
-- 09.09.2015 twie: Sprachview für Bereich (1. Ebene)
-- Filterung über Grund (2. Ebene) damit für Bereich keine Elemente angezeigt werden
-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)
-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_bereich_uid
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_bereich_bez ELSE NULL END)  AS geku_bereich_bez_bg

   FROM dbp_view.v_geku_bereich_spr_zu_1 v01

   WHERE
   v01.geku_bereich_uid IN
   (SELECT geku_bereich_uid FROM dbp_view.v_l_geku_grund_1)

   GROUP BY v01.geku_bereich_uid;