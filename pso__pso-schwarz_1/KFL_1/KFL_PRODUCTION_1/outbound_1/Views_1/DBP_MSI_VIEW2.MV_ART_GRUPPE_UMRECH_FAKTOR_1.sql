CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_gruppe_umrech_faktor_1 (mandant_id, art_id, gp_id, wup_id,
nb_id, dat, bewart_id, umrech_faktor_1, menge_af_x_umrech_faktor, menge_sa_x_umrech_faktor) AS SELECT t1.mandant_id,
 t1.art_id,
 t1.gp_id,
 t1.wup_id,
 t1.nb_id,
 t1.dat,
 t1.bewart_id,
 t1.umrech_faktor_1,
  CASE
  WHEN t1.bewart_id = 1001
  THEN t1.a0 * t1.umrech_faktor_1
  ELSE 0
  END AS menge_af_x_umrech_faktor,
  CASE
  WHEN t1.bewart_id = 1002
  THEN t1.a0 * t1.umrech_faktor_1
  ELSE 0
  END AS menge_sa_x_umrech_faktor
FROM (SELECT V01.mandant_id,
   V01.art_id,
   V01.gp_id,
   V01.wup_id,
   V01.nb_id,
   V01.dat,
   V01.bewart_id,
    CASE
    WHEN V02.umrech_faktor = 0
    THEN 1
    ELSE V02.umrech_faktor
    END AS umrech_faktor_1,
   SUM(V01.menge) AS a0
  FROM kfl_production_dbp_data.artbew_1 AS V01
   LEFT JOIN kfl_production_dbp_msi_view2.mv_art_gruppe_art_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id
     = V02.art_id
  WHERE V01.mandant_id = 1
  GROUP BY V01.mandant_id,
   V01.art_id,
   V01.gp_id,
   V01.wup_id,
   V01.nb_id,
   V01.dat,
   V01.bewart_id,
   umrech_faktor_1) AS t1_1;