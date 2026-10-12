CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_MUTTER_WB (
	MANDANT_ID,
	ART_ID,
	ART_MUTTER_WB_ID,
	ART_MUTTER_DISPLAY_ID,
	MWB_BASISMENGE_EINH_ID,
	MWB_VERPART_ID,
	ART_MUTTER_WB_NR,
	ART_MUTTER_WB_FG,
	ART_MUTTER_SAISON_ID,
	POSTEN_ID,
	POSTEN_FG,
	ART_MUTTER_WB_BEZ,
	ART_MUTTER_WB_BEZ_DE,
	ART_MUTTER_WB_BEZ_CZ,
	ART_MUTTER_WB_BEZ_SK,
	ART_MUTTER_WB_BEZ_HR,
	ART_MUTTER_WB_BEZ_PL,
	ART_MUTTER_WB_BEZ_RO,
	ART_MUTTER_WB_BEZ_BG
) AS
--2024-06-06, updating defintion of posten_fg, removing art_mutter_bezugsweg
--2024-11-19, knop, adding other languages for art_mutter_wb_bez

SELECT
 a.mandant_id
,a.art_id
,COALESCE(a.mutter_wb_id, a.art_id) AS art_mutter_wb_id
,CASE
 WHEN mwb.artikeltyp_id = 12 THEN mwb.artikeltyp_id
 ELSE mwb.display_id 
 END AS art_mutter_display_id
,mwb.basismenge_einh_id AS mwb_basismenge_einh_id
,COALESCE(mwb.verpart_id, ' ') AS mwb_verpart_id
 -- Anpassung für Snowflake, da TD-Logik abweichende Ergebnisse geliefert hat
   ,TO_VARCHAR((ABS(CASE WHEN a.mandant_id = 1 THEN (COALESCE(a.mutter_wb_id,a.art_id)/100) ELSE (COALESCE(a.mutter_wb_id,a.art_id)/10) END)), 'FM00000000')  AS art_mutter_wb_nr
   -- formatierte Mutter-Artikelnr.
   ,CASE
      WHEN a.mutter_wb_id IS NULL THEN 0
      ELSE 1
   END :: BYTEINT AS art_mutter_wb_fg 
   -- Kennzeichnung Mutterelement
, mwb.saison_id AS art_mutter_saison_id
, mwb.posten_id 
   -- Kennzeichnung von Posten

,CASE WHEN a.posten_kz_sap <> '' THEN 1 ELSE 0 END AS posten_fg
,MAX(CASE WHEN msz.spr_id =  22 THEN msz.art_bez END) AS art_mutter_wb_bez                 
,MAX(CASE WHEN msz.spr_id =  22 THEN msz.art_bez END) AS art_mutter_wb_bez_de                           
,COALESCE(MAX(CASE WHEN msz.spr_id = 124 THEN msz.art_bez END), art_mutter_wb_bez_de) AS art_mutter_wb_bez_cz    
,COALESCE(MAX(CASE WHEN msz.spr_id = 108 THEN msz.art_bez END), art_mutter_wb_bez_de) AS art_mutter_wb_bez_bez_sk    
,COALESCE(MAX(CASE WHEN msz.spr_id =  65 THEN msz.art_bez END), art_mutter_wb_bez_de) AS art_mutter_wb_bez_bez_hr    
,COALESCE(MAX(CASE WHEN msz.spr_id =  90 THEN msz.art_bez END), art_mutter_wb_bez_de) AS art_mutter_wb_bez_bez_pl    
,COALESCE(MAX(CASE WHEN msz.spr_id =  95 THEN msz.art_bez END), art_mutter_wb_bez_de) AS art_mutter_wb_bez_bez_ro    
,COALESCE(MAX(CASE WHEN msz.spr_id =  18 THEN msz.art_bez END), art_mutter_wb_bez_de) AS art_mutter_wb_bez_bez_bg    
   
FROM
   dbp_view.v_art a
   JOIN dbp_view.v_art_spr_zu msz ON msz.mandant_id = a.mandant_id
   AND msz.art_id = COALESCE(a.mutter_wb_id, a.art_id)
 
   JOIN dbp_view.v_art mwb ON mwb.mandant_id = a.mandant_id
   AND mwb.art_id = COALESCE(a.mutter_wb_id, a.art_id)
   AND mwb.dat_bis = '9999-12-31'
   
   GROUP BY 1,2,3,4,5,6,7,8,9,10,11
   ;