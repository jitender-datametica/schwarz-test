CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_we_statistik (mandant_id, beleg_kondition_id,
beleg_kondition_pos_id, beleg_konditionsart_id, werk_id, dat_buch, in_art_id, in_art_nr, artikelart_id, lagerort_id,
in_lief_id, lager_bewart_id, nettogew, menge_lagerbew_bme, basismenge_einh_id, dme_einh_id, menge_dme,
betrag_beleg_kondition_kg, wrg_id_09, default_wrg, betrag_beleg_kondition, kondition_preis_einh_id, umrech_faktor,
preis_steuer_kz, wrg_id_02, betrag_lagerbew, betrag_lagerbew_altnv) AS SELECT V01.mandant_id,
 V09.beleg_kondition_id,
 V09.beleg_kondition_pos_id,
 V08.beleg_konditionsart_id,
 v02.werk_id,
 V01.dat_buch,
 v02.flw_art_id AS in_art_id,
 V06.flw_art_nr AS in_art_nr,
 V06.artikelart_id,
 v02.lagerort_id,
 v02.flw_lief_id AS in_lief_id,
 v02.lager_bewart_id,
 v03.nettogew,
 v02.menge_lagerbew_bme,
 V06.basismenge_einh_id,
 v03.dme_einh_id,
 v03.menge_dme,
 CAST(CASE
    WHEN V06.basismenge_einh_id = 'KG'
    THEN V09.betrag_beleg_kondition
    WHEN V06.basismenge_einh_id = 'ST'
    THEN CAST(V09.betrag_beleg_kondition / V07.umrech_faktor AS NUMERIC)
    ELSE NULL
    END / COALESCE(CASE
     WHEN V09.kondition_preis_einh_id = 0
     THEN NULL
     ELSE V09.kondition_preis_einh_id
     END, 1) AS NUMERIC) AS betrag_beleg_kondition_kg,
 V09.wrg_id AS wrg_id_09,
 V100.default_wrg,
 V09.betrag_beleg_kondition,
 V09.kondition_preis_einh_id,
 V07.umrech_faktor,
 V05.preis_steuer_kz,
 v02.wrg_id AS wrg_id_02,
 v02.betrag_lagerbew,
 v02.betrag_lagerbew_altnv
FROM kfl_production_dbp_view.v_flw_lagerbew AS V01
 INNER JOIN (SELECT mandant_id,
   werk_id,
   best_beleg_id,
   best_beleg_pos_id,
   lagerbew_beleg_id,
   lagerort_id,
   kj,
   flw_art_id,
   SUM(menge_lagerbew_bme * CASE
      WHEN lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
      THEN 1
      WHEN lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
         lager_bewart_id IN ('309', '311') AND soll_haben_kz = 'H'
      THEN - 1
      WHEN lager_bewart_id IN ('309', '311') AND soll_haben_kz = 'S'
      THEN 1
      WHEN lager_bewart_id IN ('310', '312') AND soll_haben_kz = 'H'
      THEN - 1
      WHEN lager_bewart_id IN ('310', '312') AND soll_haben_kz = 'S'
      THEN 1
      ELSE NULL
      END) AS menge_lagerbew_bme,
   SUM(betrag_lagerbew * CASE
      WHEN lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
      THEN 1
      WHEN lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
         lager_bewart_id IN ('309', '311') AND soll_haben_kz = 'H'
      THEN - 1
      WHEN lager_bewart_id IN ('309', '311') AND soll_haben_kz = 'S'
      THEN 1
      WHEN lager_bewart_id IN ('310', '312') AND soll_haben_kz = 'H'
      THEN - 1
      WHEN lager_bewart_id IN ('310', '312') AND soll_haben_kz = 'S'
      THEN 1
      ELSE NULL
      END) AS betrag_lagerbew,
   SUM(betrag_lagerbew_altnv * CASE
      WHEN lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
      THEN 1
      WHEN lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
         lager_bewart_id IN ('309', '311') AND soll_haben_kz = 'H'
      THEN - 1
      WHEN lager_bewart_id IN ('309', '311') AND soll_haben_kz = 'S'
      THEN 1
      WHEN lager_bewart_id IN ('310', '312') AND soll_haben_kz = 'H'
      THEN - 1
      WHEN lager_bewart_id IN ('310', '312') AND soll_haben_kz = 'S'
      THEN 1
      ELSE NULL
      END) AS betrag_lagerbew_altnv,
   MAX(flw_lief_id) AS flw_lief_id,
   MAX(lager_bewart_id) AS lager_bewart_id,
   MAX(wrg_id) AS wrg_id
  FROM kfl_production_dbp_view.v_flw_lagerbew_det
  WHERE mandant_id IN (1, 2)
  GROUP BY mandant_id,
   werk_id,
   best_beleg_id,
   best_beleg_pos_id,
   lagerbew_beleg_id,
   lagerort_id,
   kj,
   flw_art_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.lagerbew_beleg_id = v02.lagerbew_beleg_id AND V01.kj =
   v02.kj
 LEFT JOIN (SELECT mandant_id,
   werk_id,
   best_beleg_id,
   best_beleg_pos_id,
   lagerbew_beleg_id,
   flw_art_id,
   SUM(nettogew * CASE
      WHEN storno_fg <> 1 AND retourenpos_fg <> 1
      THEN 1
      WHEN storno_fg = 1 OR retourenpos_fg = 1
      THEN - 1
      ELSE NULL
      END) AS nettogew,
   MAX(dme_einh_id) AS dme_einh_id,
   SUM(menge_dme * CASE
      WHEN storno_fg <> 1 AND retourenpos_fg <> 1
      THEN 1
      WHEN storno_fg = 1 OR retourenpos_fg = 1
      THEN - 1
      ELSE NULL
      END) AS menge_dme
  FROM kfl_production_dbp_view.v_flw_bew
  WHERE flw_beleg_typ_id = 'WE'
   AND beleg_gruppe_id = 'B'
   AND status_mb IN ('A', 'B', 'C')
   AND loesch_fg <> 1
   AND mandant_id IN (1, 2)
  GROUP BY mandant_id,
   werk_id,
   best_beleg_id,
   best_beleg_pos_id,
   lagerbew_beleg_id,
   flw_art_id) AS v03 ON v02.mandant_id = v03.mandant_id AND v02.best_beleg_id = v03.best_beleg_id AND v02.best_beleg_pos_id
      = v03.best_beleg_pos_id AND v02.lagerbew_beleg_id = v03.lagerbew_beleg_id AND v02.flw_art_id = v03.flw_art_id
 INNER JOIN kfl_production_dbp_view.v_flw_werk AS V04 ON v02.werk_id = V04.werk_id AND v02.mandant_id = V04.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per AS V05 ON V01.mandant_id = V05.mandant_id AND v02.flw_art_id
      = V05.flw_art_id AND V01.dat_buch BETWEEN V05.dat_von AND V05.dat_bis AND V04.werk_nr = V05.bewertungskreis_id
 INNER JOIN kfl_production_dbp_view.v_flw_art AS V06 ON v02.mandant_id = V06.mandant_id AND v02.flw_art_id = V06.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per AS V07 ON V06.flw_art_id = V07.flw_art_id AND V06.mandant_id
     = V07.mandant_id AND CASE
    WHEN V06.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V06.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V07.altnv_menge_einh_id
 LEFT JOIN kfl_production_dbp_view.v_flw_besch_best_kondit_zu AS V08 ON v02.mandant_id = V08.mandant_id AND v02.best_beleg_id
      = V08.best_beleg_id AND v02.best_beleg_pos_id = V08.best_beleg_pos_id AND V08.beleg_konditionsart_id IN ('PB00',
    'PBXX')
 LEFT JOIN kfl_production_dbp_view.v_flw_kondit_vorgang AS V09 ON V08.mandant_id = V09.mandant_id AND V08.beleg_kondition_id
      = V09.beleg_kondition_id AND V08.best_beleg_pos_id = V09.beleg_kondition_pos_id AND V09.beleg_konditionsart_id IN
    ('PB00', 'PBXX')
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id IN (1, 2);