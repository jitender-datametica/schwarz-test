CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_art_umrech_faktor_1 (in_art_id, mandant_id,
umrech_faktor_kg, umrech_faktor_st) AS SELECT V01.flw_art_id AS in_art_id,
 V01.mandant_id,
  CASE
  WHEN V01.basismenge_einh_id = 'KG'
  THEN 1.00
  ELSE CASE
   WHEN V01.flw_art_id >= 0
   THEN ROUND(CAST(V02.umrech_faktor AS BIGNUMERIC), 5)
   WHEN V01.flw_art_id < 0
   THEN ROUND(CAST(V04.umrech_faktor AS BIGNUMERIC), 5)
   ELSE NULL
   END
  END AS umrech_faktor_kg,
  CASE
  WHEN V01.basismenge_einh_id = 'ST'
  THEN 1.00
  ELSE CASE
   WHEN V01.flw_art_id >= 0
   THEN ROUND(CAST(V03.umrech_faktor AS BIGNUMERIC), 5)
   WHEN V01.flw_art_id < 0
   THEN ROUND(CAST(V05.umrech_faktor AS BIGNUMERIC), 5)
   ELSE NULL
   END
  END AS umrech_faktor_st
FROM kfl_production_dbp_msi_view_flw.mv_l_in_art_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V02 ON V01.flw_art_id = V02.flw_art_id AND V01.mandant_id
     = V02.mandant_id AND V02.altnv_menge_einh_id = 'KG'
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V03 ON V01.flw_art_id = V03.flw_art_id AND V01.mandant_id
     = V03.mandant_id AND V03.altnv_menge_einh_id = 'ST'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.art_id
     = V04.art_id AND V04.altnv_menge_einh_id = 'KG' AND V04.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.art_id
     = V05.art_id AND V05.altnv_menge_einh_id = 'ST' AND V05.dat_bis = DATE '9999-12-31';