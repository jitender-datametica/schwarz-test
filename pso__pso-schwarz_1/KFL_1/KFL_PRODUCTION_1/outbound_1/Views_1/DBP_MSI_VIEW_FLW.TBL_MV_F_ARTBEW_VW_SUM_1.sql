CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_vw_sum_1 AS
-- Artikel_1, die es nur im Retail gibt (Dummy_1 flw_art_id < 0) mit Retail Umrechnungsfaktor multiplizieren

-- MARA_1 + Retailartikel
 SELECT V01.dat,
 V01.mandant_id,
 V01.art_id,
 V01.vw_id,
 V03.flw_art_id AS in_art_id,
 V03.in_art_nr,
 V01.menge AS vk_menge_org,
 V03.basismenge_einh_id,
  CASE
  WHEN V03.basismenge_einh_id = 'KG' AND V03.flw_art_id >= 0
  THEN ROUND(CAST(V01.menge * V06.umrech_faktor AS NUMERIC), 6)
  WHEN V03.basismenge_einh_id = 'KG' AND V03.flw_art_id < 0
  THEN ROUND(CAST(V01.menge * V07.umrech_faktor AS NUMERIC), 6)
  WHEN V03.basismenge_einh_id = 'ST'
  THEN V01.menge
  ELSE NULL
  END AS vk_menge_st,
  CASE
  WHEN V03.basismenge_einh_id = 'KG'
  THEN V01.menge
  WHEN V03.basismenge_einh_id = 'ST' AND V03.flw_art_id >= 0
  THEN ROUND(CAST(V01.menge * V06.umrech_faktor AS NUMERIC), 6)
  WHEN V03.basismenge_einh_id = 'ST' AND V03.flw_art_id < 0
  THEN ROUND(CAST(V01.menge * V07.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS vk_menge_kg,
  CASE
  WHEN V08.wg_id IN (122, 128, 146, 147, 184, 186)
  THEN V01.ek_mep
  ELSE NULL
  END AS ek_mep_umsatz_temp,
 V01.bewart_id,
 V01.gp_id,
 V01.wrg_id,
 V100.default_wrg,
 V01.umsatz_netto
FROM kfl_production_dbp_view.v_artbew_vw_sum_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_1 AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V06 ON V03.mandant_id = V06.mandant_id AND V03.flw_art_id
     = V06.flw_art_id AND CASE
    WHEN V03.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V03.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V06.altnv_menge_einh_id
 LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per_1 AS V07 ON V03.mandant_id = V07.mandant_id AND V03.art_id
     = V07.art_id AND CASE
     WHEN V03.basismenge_einh_id = 'ST'
     THEN 'KG'
     WHEN V03.basismenge_einh_id = 'KG'
     THEN 'ST'
     ELSE NULL
     END = V07.altnv_menge_einh_id AND V07.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_art_wg_zu_per_1 AS V08 ON V03.flw_art_id = V08.flw_art_id AND V03.mandant_id
    = V08.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V08.arthiertyp_id = 2;