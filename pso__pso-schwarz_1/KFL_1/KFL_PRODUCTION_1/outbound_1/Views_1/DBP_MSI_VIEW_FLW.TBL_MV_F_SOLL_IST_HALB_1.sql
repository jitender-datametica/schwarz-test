CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_soll_ist_halb_1 (werk_nr, werk_name, mandant_id,
auftrag_id, halb_in_art_id, halb_in_art_nr, in_art_id, typ, basismenge_einh_id, in_art_nr, artikelart_id, werk_id,
dat_start, menge_lagerbew_bme, input_menge_ist, input_menge_soll, menge_kg, wrg_id, gld, preis_faktor, preis_steuer_kz,
standard_preis, default_wrg, umrech_faktor) AS SELECT DT7.werk_nr,
 DT7.werk_name,
 dt2.mandant_id,
 dt2.auftrag_id,
 dt2.halb_flw_art_id AS halb_in_art_id,
 DT9.flw_art_nr AS halb_in_art_nr,
 dt2.flw_art_id AS in_art_id,
 dt2.typ,
 dt2.basismenge_einh_id,
 dt2.flw_art_nr AS in_art_nr,
 dt2.artikelart_id,
 dt2.werk_id,
 dt2.dat_start,
 dt2.output_menge_ist_bme AS menge_lagerbew_menge_bme,
 dt2.input_menge_ist,
 dt2.input_menge_soll,
  CASE
  WHEN dt2.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(dt2.output_menge_ist_bme * V600.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_kg,
 DT8.wrg_id,
 DT8.gld,
 DT8.preis_faktor,
 DT8.preis_steuer_kz,
 DT8.standard_preis,
 V100.default_wrg,
 V600.umrech_faktor
FROM (SELECT V01.mandant_id,
    V01.auftrag_id,
    V07.dat_start,
    V05.flw_art_id AS halb_flw_art_id,
    V06.flw_art_id,
    'output' AS typ,
    V66.basismenge_einh_id,
    V66.flw_art_nr,
    V66.artikelart_id,
    V08.werk_id,
    SUM(V08.menge_lagerbew_bme) AS output_menge_ist_bme,
    CAST(NULL AS NUMERIC) AS input_menge_ist,
    CAST(NULL AS NUMERIC) AS input_menge_soll
   FROM kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V01
    INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_det_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.flw_art_id
       = V05.flw_art_id
    INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.stueckliste_id
        = V06.stueckliste_id AND V05.stueckliste_typ_id = V06.stueckliste_typ_id
    INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V66 ON V06.mandant_id = V66.mandant_id AND V06.flw_art_id = V66.flw_art_id
      
    INNER JOIN kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V07 ON V06.mandant_id = V07.mandant_id AND V06.flw_art_id =
       V07.flw_art_id AND V01.dat_start = V07.dat_start
    INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_det_1 AS V08 ON V07.mandant_id = V08.mandant_id AND V07.auftrag_id =
      V08.auftrag_id
   WHERE V08.lager_bewart_id IN ('101', '102')
    AND V05.komponentenmenge > 0.001
    AND V01.mandant_id IN (1, 2)
   GROUP BY V01.mandant_id,
    V01.auftrag_id,
    V05.komponentenmenge,
    V05.stueckliste_id,
    V05.stueckliste_typ_id,
    halb_flw_art_id,
    V06.flw_art_id,
    V66.basismenge_einh_id,
    V66.flw_art_nr,
    V66.artikelart_id,
    V08.werk_id,
    V07.dat_start,
    V06.menge_basis
   UNION ALL
   SELECT V01.mandant_id,
    V01.auftrag_id,
    V01.dat_start,
    V01.flw_art_id AS halb_flw_art_id,
    V03.flw_art_id,
    'input' AS typ,
    V04.basismenge_einh_id,
    V04.flw_art_nr,
    V04.artikelart_id,
    V03.werk_id,
    CAST(NULL AS NUMERIC) AS output_menge_ist_bme,
    SUM(V03.menge_lagerbew_bme) AS input_menge_ist,
    CAST(NULL AS NUMERIC) AS input_menge_soll
   FROM kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V01
    INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_art_id = V02.flw_art_id
      
    INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_det_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.auftrag_id =
      V03.auftrag_id
    INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.flw_art_id = V04.flw_art_id
      
   WHERE V03.lager_bewart_id IN ('261', '262')
    AND V02.artikelart_id = 'HALB'
    AND V02.mandant_id IN (1, 2)
   GROUP BY V01.mandant_id,
    halb_flw_art_id,
    V04.basismenge_einh_id,
    V04.flw_art_nr,
    V04.artikelart_id,
    V01.auftrag_id,
    V01.dat_start,
    V03.werk_id,
    V03.flw_art_id,
    V03.kj
   UNION ALL
   SELECT dt5.mandant_id,
    dt5.auftrag_id,
    dt5.dat_start,
    dt5.halb_flw_art_id,
    dt5.flw_art_id,
    'input' AS typ,
    dt5.basismenge_einh_id,
    dt5.flw_art_nr,
    dt5.artikelart_id,
    dt4.werk_id,
    CAST(NULL AS NUMERIC) AS inp_menge_lagerbew_bme,
    CAST(NULL AS NUMERIC) AS output_menge_ist_bme,
      MAX(dt4.benoetigtes_halb_sum) * MAX(dt5.komponentenmenge) / MAX(dt5.menge_basis) AS input_menge_soll
   FROM (SELECT V01.mandant_id,
      V01.auftrag_id,
      V01.dat_start,
      V02.basismenge_einh_id,
      V02.flw_art_nr,
      V02.artikelart_id,
      V08.werk_id,
      V05.flw_art_id AS halb_flw_art_id,
      V06.flw_art_id,
      V05.komponentenmenge,
      V06.menge_basis,
      SUM(SUM(V08.menge_lagerbew_bme) * V05.komponentenmenge / V06.menge_basis) OVER (PARTITION BY CAST(V01.mandant_id AS STRING)
         , V01.auftrag_id, V01.dat_start, V02.basismenge_einh_id, V02.artikelart_id, CAST(V08.werk_id AS STRING), CAST(V05.flw_art_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS benoetigtes_halb_sum
     FROM kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V01
      INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_det_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.flw_art_id
         = V05.flw_art_id
      INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.stueckliste_id
          = V06.stueckliste_id AND V05.stueckliste_typ_id = V06.stueckliste_typ_id
      INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V02 ON V06.mandant_id = V02.mandant_id AND V06.flw_art_id = V02.flw_art_id
        
      INNER JOIN kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V07 ON V06.mandant_id = V07.mandant_id AND V06.flw_art_id
         = V07.flw_art_id AND V01.dat_start = V07.dat_start
      INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_det_1 AS V08 ON V07.mandant_id = V08.mandant_id AND V07.auftrag_id
         = V08.auftrag_id
      INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_1 AS V09 ON V08.mandant_id = V09.mandant_id AND V08.lagerbew_beleg_id
          = V09.lagerbew_beleg_id AND V08.kj = V09.kj
     WHERE V08.lager_bewart_id IN ('101', '102')
      AND V05.komponentenmenge > 0.001
      AND V02.artikelart_id = 'ZFER'
      AND V01.mandant_id IN (1, 2)
     GROUP BY V01.mandant_id,
      V01.auftrag_id,
      V01.dat_start,
      V02.basismenge_einh_id,
      V02.flw_art_nr,
      V02.artikelart_id,
      V08.werk_id,
      V05.komponentenmenge,
      halb_flw_art_id,
      V06.flw_art_id,
      V06.menge_basis) AS dt4
    INNER JOIN (SELECT V010.mandant_id,
      V010.flw_art_id AS halb_flw_art_id,
      V010.auftrag_id,
      V010.dat_start,
      V020.basismenge_einh_id,
      V020.flw_art_nr,
      V020.artikelart_id,
      V050.komponentenmenge,
      V050.flw_art_id,
      V060.menge_basis,
      V060.werk_id
     FROM kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V010
      INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_1 AS V060 ON V010.mandant_id = V060.mandant_id AND V010.flw_art_id
         = V060.flw_art_id
      INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_det_1 AS V050 ON V060.mandant_id = V050.mandant_id AND V060.stueckliste_id
          = V050.stueckliste_id AND V060.stueckliste_typ_id = V050.stueckliste_typ_id
      INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V020 ON V050.mandant_id = V020.mandant_id AND V050.flw_art_id =
        V020.flw_art_id
     WHERE V050.komponentenmenge > 0.001
      AND V020.artikelart_id = 'ZERL'
      AND V010.mandant_id IN (1, 2)
     GROUP BY V010.mandant_id,
      halb_flw_art_id,
      V010.auftrag_id,
      V010.dat_start,
      V020.basismenge_einh_id,
      V020.flw_art_nr,
      V020.artikelart_id,
      V050.komponentenmenge,
      V050.flw_art_id,
      V060.menge_basis,
      V060.werk_id) AS dt5 ON dt4.mandant_id = dt5.mandant_id AND dt4.halb_flw_art_id = dt5.halb_flw_art_id AND dt4.auftrag_id
         = dt5.auftrag_id AND dt4.dat_start = dt5.dat_start AND dt4.werk_id = dt5.werk_id
   GROUP BY dt5.mandant_id,
    dt5.auftrag_id,
    dt5.dat_start,
    dt5.basismenge_einh_id,
    dt5.flw_art_nr,
    dt5.artikelart_id,
    dt4.werk_id,
    dt5.halb_flw_art_id,
    dt5.flw_art_id) AS dt2
 INNER JOIN kfl_production_dbp_view.v_flw_werk_1 AS DT7 ON dt2.mandant_id = DT7.mandant_id AND dt2.werk_id = DT7.werk_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per_1 AS DT8 ON dt2.mandant_id = DT8.mandant_id AND dt2.flw_art_id
      = DT8.flw_art_id AND dt2.dat_start BETWEEN DT8.dat_von AND DT8.dat_bis AND DT7.werk_nr = DT8.bewertungskreis_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_1 AS DT9 ON dt2.mandant_id = DT9.mandant_id AND dt2.halb_flw_art_id = DT9.flw_art_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON dt2.mandant_id = V100.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V600 ON dt2.flw_art_id = V600.flw_art_id AND dt2.mandant_id
     = V600.mandant_id AND CASE
    WHEN dt2.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN dt2.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V600.altnv_menge_einh_id;