CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_ADRESSE_ZU_GES
-- #P0730 Dummy-nb_id hinzugefügt - sschuecke 29062016
-- Erweiterung um Dummy -1 / sschuecke 09.08.2016

(
mandant_id
,wup_id
,nb_id
,land_id
,bundesland_id
,gemeinde_id
,umland_id
,naturpark_id
,naturraum_id
,dummy_id
,dummy2_id
)
AS
   SELECT
   v01.mandant_id, v01.wup_id, 0 AS nb_id, COALESCE(v01.land_id,-1) AS land_id, COALESCE(v01.bundesland_id,-1) AS bundesland_id, COALESCE(v01.gemeinde_id,-1) AS gemeinde_id, COALESCE(v01.umland_id,-1) AS umland_id, COALESCE(v01.naturpark_id,-1) AS naturpark_id, COALESCE(v01.naturraum_id,-1) AS naturraum_id, COALESCE(v01.dummy_id,-1) AS dummy_id, COALESCE(v01.dummy2_id,-1) AS dummy2_id
   FROM
   (
   SELECT
   a02.mandant_id, wup_id, MAX(CASE WHEN regio_stufe_id = 30 THEN regio_polygon_id ELSE NULL END) AS land_id, MAX(CASE WHEN regio_stufe_id = 20 THEN regio_polygon_id ELSE NULL END) AS bundesland_id, MAX(CASE WHEN regio_stufe_id = 10 THEN regio_polygon_id ELSE NULL END) AS gemeinde_id, MAX(CASE WHEN regio_stufe_id = 40 THEN regio_polygon_id ELSE NULL END) AS umland_id, MAX(CASE WHEN regio_stufe_id = 50 THEN regio_polygon_id ELSE NULL END) AS naturpark_id, MAX(CASE WHEN regio_stufe_id = 60 THEN regio_polygon_id ELSE NULL END) AS naturraum_id, MAX(CASE WHEN regio_stufe_id = 70 THEN regio_polygon_id ELSE NULL END) AS dummy_id, MAX(CASE WHEN regio_stufe_id = 80 THEN regio_polygon_id ELSE NULL END) AS dummy2_id
   FROM dbp_view.v_regio_polygon_adresse_zu a01
   JOIN dbp_view.v_wup a02
   ON a01.mandant_id = a02.mandant_id
   AND a01.adresse_id = a02.adresse_id

   WHERE a02.mandant_id = 1
   GROUP BY a02.mandant_id
   ,a02.wup_id
   ) v01;