CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIO_POLYGON_ADRESSE_ZU_1
-- #P0730 Dummy_1-nb_id hinzugefügt - sschuecke 20160629

(
mandant_id
, regio_stufe_id
, regio_polygon_id
, wup_id
, nb_id
)
AS
   SELECT
   v01.mandant_id, v01.regio_stufe_id, v01.regio_polygon_id, v02.wup_id, 0 AS nb_id
   FROM dbp_view.v_regio_polygon_adresse_zu_1 v01
   JOIN dbp_view.v_wup_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.adresse_id = v02.adresse_id
   WHERE v01.mandant_id = 1;