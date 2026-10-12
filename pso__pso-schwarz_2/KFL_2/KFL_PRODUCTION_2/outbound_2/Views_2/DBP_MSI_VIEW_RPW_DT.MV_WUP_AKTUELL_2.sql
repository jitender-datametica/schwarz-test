CREATE OR REPLACE VIEW dbp_msi_view_rpw_dt.mv_wup_aktuell_2 (aktuell_wup_id, mandant_id, wup_standort) AS SELECT V01.aktuell_wup_id
 ,
 V01.mandant_id,
 MAX(CASE
   WHEN V01.dat_bis < DATE '9999-12-31'
   THEN CHR(123) || V01.wup_standort || CHR(125)
   ELSE V01.wup_standort
   END) AS wup_standort
FROM kfl_production_dbp_view.v_wup_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id_alt AND
   V01.nb_id = V02.nb_id
WHERE V01.mandant_id = 1
 AND V02.wup_id_alt IS NULL
 AND (V01.nb_id IN (0, -111, 2, 99) OR V01.wup_id = 0 AND V01.nb_id = -1 OR V01.nb_id = -1 AND V01.vw_id = 6)
GROUP BY V01.aktuell_wup_id,
 V01.mandant_id;