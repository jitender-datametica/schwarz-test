CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_bewart (mandant_id, mandant_kbez, bwart) AS SELECT V01.mandant_id
 ,
 V02.mandant_kbez,
 SUBSTR(CAST(V01.lager_bewart_id AS STRING), 1, 3) AS bwart
FROM kfl_production_dbp_view.v_l_lager_bewart AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id;