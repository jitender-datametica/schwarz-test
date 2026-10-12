CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_adresse_zu (mandant_id, regio_stufe_id,
regio_polygon_id, wup_id, nb_id) AS SELECT V01.mandant_id,
 V01.regio_stufe_id,
 V01.regio_polygon_id,
 V02.wup_id,
 0 AS nb_id
FROM kfl_production_dbp_view.v_regio_polygon_adresse_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.mandant_id = V02.mandant_id AND V01.adresse_id = V02.adresse_id
WHERE V01.mandant_id = 1;