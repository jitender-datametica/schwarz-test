create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_RISIKOKLASSE_SPR_ZU_2(
	GEKU_RISIKOKLASSE_ID,
	GEKU_RISIKOKLASSE_BEZ,
	GEKU_RISIKOKLASSE_BEZ_CZ,
	GEKU_RISIKOKLASSE_BEZ_PL,
	GEKU_RISIKOKLASSE_BEZ_SK,
	GEKU_RISIKOKLASSE_BEZ_HR,
	GEKU_RISIKOKLASSE_BEZ_RO,
	GEKU_RISIKOKLASSE_BEZ_BG
) as
-- 25.11.2015 twie: SPEC0003061 neues Attribut Risikoklasse, Eltern von Prioritaet
-- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

   SELECT
   v01.geku_risikoklasse_id
   , MAX(CASE WHEN v01.spr_id =   22 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id = 124 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez_cz
   , MAX(CASE WHEN v01.spr_id =   90 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez_pl
   , MAX(CASE WHEN v01.spr_id = 108 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez_sk
   , MAX(CASE WHEN v01.spr_id =   65 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez_hr
   , MAX(CASE WHEN v01.spr_id =   95 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez_ro
   , MAX(CASE WHEN v01.spr_id =   18 THEN (CASE WHEN geku_risikoklasse_id = 0 THEN '' ELSE v01.geku_risikoklasse_bez END) ELSE NULL END)  AS geku_risikoklasse_bez_bg

   FROM dbp_view.v_geku_risikoklasse_spr_zu_2 v01

   GROUP BY v01.geku_risikoklasse_id;