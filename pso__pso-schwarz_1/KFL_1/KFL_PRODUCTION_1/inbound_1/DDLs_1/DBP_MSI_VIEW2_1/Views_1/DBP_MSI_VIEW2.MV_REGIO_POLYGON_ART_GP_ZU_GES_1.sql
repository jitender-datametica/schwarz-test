CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_ART_GP_ZU_GES_1
-- Erweiterung um Dummy_1 -1 / sschuecke 09.08.2016
(mandant_id
,art_id
,gp_id
,land_id
,bundesland_id
,gemeinde_id
,umland_id
,naturpark_id
,naturraum_id
,dummy_id
,dummy2_id
--,v01.genehmigt_fg
)

AS
   SELECT
   v01.mandant_id, v01.art_id, v01.gp_id, COALESCE(v01.land_id,-1) AS land_id, COALESCE(v01.bundesland_id,-1) AS bundesland_id, COALESCE(v01.gemeinde_id,-1) AS gemeinde_id, COALESCE(v01.umland_id,-1) AS umland_id, COALESCE(v01.naturpark_id,-1) AS naturpark_id, COALESCE(v01.naturraum_id,-1) AS naturraum_id, COALESCE(v01.dummy_id,-1) AS dummy_id, COALESCE(v01.dummy2_id,-1) AS dummy2_id
   --,v01.genehmigt_fg
   FROM
   (
   SELECT
   mandant_id, art_id, gp_id--, genehmigt_fg
   , MAX(CASE WHEN regio_stufe_id = 30 THEN regio_polygon_id ELSE NULL END) AS land_id, MAX(CASE WHEN regio_stufe_id = 20 THEN regio_polygon_id ELSE NULL END) AS bundesland_id, MAX(CASE WHEN regio_stufe_id = 10 THEN regio_polygon_id ELSE NULL END) AS gemeinde_id, MAX(CASE WHEN regio_stufe_id = 40 THEN regio_polygon_id ELSE NULL END) AS umland_id, MAX(CASE WHEN regio_stufe_id = 50 THEN regio_polygon_id ELSE NULL END) AS naturpark_id, MAX(CASE WHEN regio_stufe_id = 60 THEN regio_polygon_id ELSE NULL END) AS naturraum_id, MAX(CASE WHEN regio_stufe_id = 70 THEN regio_polygon_id ELSE NULL END) AS dummy_id, MAX(CASE WHEN regio_stufe_id = 80 THEN regio_polygon_id ELSE NULL END) AS dummy2_id
   --  ,MAX(CASE WHEN genehmigt_fg = 1 THEN 'X' ELSE NULL END) AS genehmigt_fg
   FROM
   dbp_view.v_regio_polygon_art_gp_zu_1
   WHERE mandant_id = 1
   GROUP BY mandant_id
   ,art_id
   ,gp_id
   --,genehmigt_fg
   ) v01;