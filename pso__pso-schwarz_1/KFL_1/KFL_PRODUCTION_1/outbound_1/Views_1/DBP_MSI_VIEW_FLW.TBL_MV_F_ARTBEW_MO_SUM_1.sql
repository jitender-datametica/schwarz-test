-- 30.11.2011 MR Performance art_id Verbindung

-- 18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt

-- 02.10.2013 twie: Erweitert um mandant_id 2
 -- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 26.10.2011 system_id entfernt

-- 21.10.2013 twie: CROSS JOIN auf in_art_1 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen

-- 24.10.2013 twie: gp_id ausgeben
 -- ,system_id

-- 13.02.2014 twie: ek_mep ausgeben, diff_umsatz_netto_konz entfernen

-- 29.01.2014 twie: Waehrungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.

-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen

-- 22.10.2013 twie: CROSS JOIN zu in_kunde_1 vereinfacht ueber wup_id

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_mo_sum_1 (kjmo, mandant_id, art_id, in_kunde_id,
kunde_nr, kunde_name, in_art_id, in_art_nr, vk_menge_org, basismenge_einh_id, vk_menge_st, vk_menge_kg,
ek_mep_umsatz_temp, bewart_id, gp_id, default_wrg, max_dat, umsatz_netto) AS
-- Artikel_1, die es nur im Retail gibt (Dummy_1 flw_art_id < 0) mit Retail Umrechnungsfaktor multiplizieren

-- MARA_1 + Retailartikel
 SELECT V01.kjmo,
 V01.mandant_id,
 V01.art_id,
 V05.flw_kunde_id AS in_kunde_id,
 COLLATE(LTRIM(COLLATE(V05.kunde_nr, ''), '0'), 'und:ci') AS kunde_nr,
 V05.kunde_name,
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
  WHEN V09.wg_id IN (122, 128, 146, 147, 184, 186)
  THEN V01.ek_mep
  ELSE NULL
  END AS ek_mep_umsatz_temp,
 V01.bewart_id,
 V01.gp_id,
 V100.default_wrg,
 V08.max_dat,
 V01.umsatz_netto
FROM kfl_production_dbp_view.v_artbew_mo_sum_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_1 AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_1 AS V05 ON V01.wup_id = V05.wup_id AND V01.mandant_id = V05.mandant_id
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
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V08 ON V01.kjmo = V08.kjmo
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_art_wg_zu_per_1 AS V09 ON V03.flw_art_id = V09.flw_art_id AND V03.mandant_id
    = V09.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V09.arthiertyp_id = 2;