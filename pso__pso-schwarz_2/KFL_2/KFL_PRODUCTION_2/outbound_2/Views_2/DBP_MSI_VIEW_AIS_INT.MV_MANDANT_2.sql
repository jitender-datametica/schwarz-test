CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_mandant_2 (mandant_id, mandant_kbez) AS SELECT V01.mandant_id
 ,
 V01.mandant_kbez
FROM kfl_production_dbp_view.v_mandant_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_land_2 AS V02 ON CASE
   WHEN V01.mandant_kbez = 'D'
   THEN 'DE'
   ELSE V01.mandant_kbez
   END = V02.land_id
GROUP BY V01.mandant_id,
 V01.mandant_kbez;