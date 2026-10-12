CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_REGIO_ART_GP_WUP_ZU_GES_2
(
	MANDANT_ID,
	REGIO_STUFE_ID,
	GP_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	REGIO_POLYGON_ID,
	LAND_ID,
	BUNDESLAND_ID,
	GEMEINDE_ID,
	UMLAND_ID,
	NATURPARK_ID,
	NATURRAUM_ID,
	DUMMY_ID,
	DUMMY2_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.mandant_id, 
v01.regio_stufe_id, 
v01.gp_id, 
v01.art_id, 
v01.wup_id, 
v01.nb_id, 
v01.regio_polygon_id, 
v01.land_id, 
v01.bundesland_id, 
v01.gemeinde_id, 
v01.umland_id, 
v01.naturpark_id, 
v01.naturraum_id, 
v01.dummy_id, 
v01.dummy2_id

FROM
   (
   SELECT
   mandant_id, 
   regio_stufe_id, 
   art_id, 
   gp_id, 
   wup_id, 
   nb_id, 
   regio_polygon_id, 
   MAX(CASE WHEN regio_stufe_id = 30 THEN regio_polygon_id ELSE NULL END) AS land_id, 
   MAX(CASE WHEN regio_stufe_id = 20 THEN regio_polygon_id ELSE NULL END) AS bundesland_id, 
   MAX(CASE WHEN regio_stufe_id = 10 THEN regio_polygon_id ELSE NULL END) AS gemeinde_id, 
   MAX(CASE WHEN regio_stufe_id = 40 THEN regio_polygon_id ELSE NULL END) AS umland_id, 
   MAX(CASE WHEN regio_stufe_id = 50 THEN regio_polygon_id ELSE NULL END) AS naturpark_id, 
   MAX(CASE WHEN regio_stufe_id = 60 THEN regio_polygon_id ELSE NULL END) AS naturraum_id, 
   MAX(CASE WHEN regio_stufe_id = 70 THEN regio_polygon_id ELSE NULL END) AS dummy_id, 
   MAX(CASE WHEN regio_stufe_id = 80 THEN regio_polygon_id ELSE NULL END) AS dummy2_id
   FROM dbp_view.v_regio_art_gp_wup_zu_2
   WHERE mandant_id = 1
   AND loesch_fg = 0
   GROUP BY mandant_id
   ,regio_stufe_id
   ,art_id
   ,gp_id
   ,wup_id
   ,nb_id
   ,regio_polygon_id
   ) v01;
