create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_EBENE_4_SPR_ZU_2(
	GEKU_ARTIKEL_ID,
	GEKU_DWH_ARTIKEL_ID,
	GEKU_ARTIKEL_BEZ,
	GEKU_ARTIKEL_BEZ_CZ,
	GEKU_ARTIKEL_BEZ_PL,
	GEKU_ARTIKEL_BEZ_SK,
	GEKU_ARTIKEL_BEZ_HR,
	GEKU_ARTIKEL_BEZ_RO,
	GEKU_ARTIKEL_BEZ_BG
) as
-- 23.10.2015 twie: neues Attribut als Eltern von Artikel_2, da Artikel_2 nicht auswertbar ist aufgrund aktiv/deaktiv
-- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT

   v01.geku_artikel_id
   , v01.geku_dwh_artikel_id
   , MAX(CASE WHEN v03.spr_id =   22 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez   --standard=deutsch
   , MAX(CASE WHEN v03.spr_id = 124 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_cz
   , MAX(CASE WHEN v03.spr_id =   90 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_pl
   , MAX(CASE WHEN v03.spr_id = 108 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_sk
   , MAX(CASE WHEN v03.spr_id =   65 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_hr
   , MAX(CASE WHEN v03.spr_id =   95 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_ro
   , MAX(CASE WHEN v03.spr_id =   18 THEN v03.geku_artikel_bez ELSE NULL END)  AS geku_artikel_bez_bg

   FROM dbp_view.v_l_geku_artikel_2 v01

   --Ermittlung der Bezeichung vom führenden Artikel_2 dieses DWH Artikels
   JOIN dbp_view.v_l_geku_dwh_artikel_2 v02
   ON v01.geku_dwh_artikel_id = v02.geku_dwh_artikel_id

   JOIN dbp_view.v_geku_artikel_spr_zu_2 v03
   ON v02.geku_artikel_uid = v03.geku_artikel_uid

   GROUP BY 1,2;