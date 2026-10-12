CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_artikelart_2 (mandant_id, mandant_kbez, mtart) AS SELECT V01.mandant_id
 ,
 V02.mandant_kbez,
 V01.artikelart_id AS mtart
FROM kfl_production_dbp_view.v_l_artikelart_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id;