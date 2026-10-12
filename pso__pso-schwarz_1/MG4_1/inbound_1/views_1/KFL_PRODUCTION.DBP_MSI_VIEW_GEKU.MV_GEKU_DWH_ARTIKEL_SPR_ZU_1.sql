create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_DWH_ARTIKEL_SPR_ZU_1(
	GEKU_DWH_ARTIKEL_ID,
	KMR_QUELLE_ID,
	GEKU_DWH_ARTIKEL_BEZ,
	GEKU_DWH_ARTIKEL_BEZ_CZ,
	GEKU_DWH_ARTIKEL_BEZ_PL,
	GEKU_DWH_ARTIKEL_BEZ_SK,
	GEKU_DWH_ARTIKEL_BEZ_HR,
	GEKU_DWH_ARTIKEL_BEZ_RO,
	GEKU_DWH_ARTIKEL_BEZ_BG,
	GEKU_DWH_ARTIKEL_BEZ2,
	GEKU_DWH_ARTIKEL_BEZ2_CZ,
	GEKU_DWH_ARTIKEL_BEZ2_PL,
	GEKU_DWH_ARTIKEL_BEZ2_SK,
	GEKU_DWH_ARTIKEL_BEZ2_HR,
	GEKU_DWH_ARTIKEL_BEZ2_RO,
	GEKU_DWH_ARTIKEL_BEZ2_BG
) as
-- 09.09.2015 twie: Sprachview für DWH Artikel_1 (3. Ebene)
-- Filterung über Artikel_1 (4. Ebene) damit für DWH Artikel_1 keine Elemente angezeigt werden
-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)
-- 13.11.2015 twie: Bezeichnungsfeld, das die alten gemappten Ebene 4 Nummern enthält
-- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert
-- 31.01.2018 twie: SPEC0032924 die bez2 bei Artikel_1 ID zw. 2500 und 5999 mit (alt 2017) erweitern
-- 19.02.2018 twie: SPEC0034180 Case Bedingung nochmals angepasst
-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel_1 um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

   SELECT

   v01.geku_dwh_artikel_id
   , 3 AS kmr_quelle_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN v01.geku_dwh_artikel_bez ELSE NULL END)  AS geku_dwh_artikel_bez_bg
   , MAX(CASE WHEN v01.spr_id =   22 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2
   , MAX(CASE WHEN v01.spr_id =   124 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2_pl
   , MAX(CASE WHEN v01.spr_id =   108 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN (
   CASE WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999 THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
   WHEN v02.alt_fg = 1 THEN v01.geku_dwh_artikel_bez || ' (alt)'
   ELSE (
   CASE WHEN v02.geku_artikel_id_alt IS NULL THEN v01.geku_dwh_artikel_bez
   ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
   END )
   END )
   ELSE NULL END) AS geku_dwh_artikel_bez2_bg

   FROM dbp_view.v_geku_dwh_artikel_spr_zu_1 v01

   JOIN dbp_view.v_l_geku_dwh_artikel_1 v02
   ON v01.geku_dwh_artikel_id = v02.geku_dwh_artikel_id

   WHERE  v01.geku_dwh_artikel_id IN
   (SELECT geku_dwh_artikel_id FROM dbp_view.v_l_geku_artikel_1)

   GROUP BY v01.geku_dwh_artikel_id;