CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_nb_1 (mandant_id, mandant_kbez, nb_id, nb_bez) AS SELECT V02.mandant_id
 ,
 V02.mandant_kbez,
 V01.nb_id,
 V01.nb_bez
FROM kfl_production_dbp_view.v_nb_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.nb_id <> 6 AND V02.mandant_id <> 1 AND V01.nb_id NOT IN (- 2
     , 2, 7) OR V02.mandant_id = 1 AND V01.nb_id NOT IN (6);