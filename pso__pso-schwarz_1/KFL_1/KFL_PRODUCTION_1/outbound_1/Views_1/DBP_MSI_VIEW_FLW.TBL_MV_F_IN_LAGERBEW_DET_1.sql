CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_in_lagerbew_det_1 AS SELECT V01.lagerbew_beleg_id,
 V02.lagerbew_beleg_pos_id,
 V01.mandant_id,
 V01.kj,
 V02.werk_id,
 V01.dat_buch,
 V02.flw_art_id AS in_art_id,
 V07.flw_art_nr AS in_art_nr,
 V07.artikelart_id,
 V02.lager_bewart_id,
 V02.auto_id,
 V02.flw_lief_id AS in_lief_id,
 V02.charge_id,
 V02.soll_haben_kz,
 V02.empfaenger_id,
 V02.wrg_id,
 V100.default_wrg,
 V02.betrag_lagerbew,
 V02.betrag_lagerbew_altnv,
  CASE
  WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
  THEN 1
  WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
     V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
  THEN - 1
  WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
  THEN 1
  WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
  THEN - 1
  WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
  THEN 1
  ELSE NULL
  END AS vorzeichen,
  V02.menge_lagerbew_bme * CASE
   WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
   THEN 1
   WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
      V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
   THEN 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
   THEN 1
   ELSE NULL
   END AS menge_lagerbew_bme,
  V02.menge_bstmg * CASE
   WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
   THEN 1
   WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
      V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
   THEN 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
   THEN 1
   ELSE NULL
   END AS menge_bstmg,
 V02.best_menge_einh_id,
  CASE
  WHEN V07.basismenge_einh_id = 'KG'
  THEN ROUND(CAST(V02.menge_lagerbew_bme * CASE
       WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
       THEN 1
       WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
       THEN - 1
       WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
       THEN 1
       WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
       THEN - 1
       WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
       THEN 1
       ELSE NULL
       END * V06.umrech_faktor AS NUMERIC), 6)
  WHEN V07.basismenge_einh_id = 'ST'
  THEN V02.menge_lagerbew_bme * CASE
    WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
    THEN 1
    WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
       V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
    THEN - 1
    WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
    THEN 1
    WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
    THEN - 1
    WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
    THEN 1
    ELSE NULL
    END
  ELSE NULL
  END AS menge_st,
  CASE
  WHEN V07.basismenge_einh_id = 'KG'
  THEN V02.menge_lagerbew_bme * CASE
    WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
    THEN 1
    WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
       V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
    THEN - 1
    WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
    THEN 1
    WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
    THEN - 1
    WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
    THEN 1
    ELSE NULL
    END
  WHEN V07.basismenge_einh_id = 'ST'
  THEN ROUND(CAST(V02.menge_lagerbew_bme * CASE
       WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
       THEN 1
       WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
       THEN - 1
       WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
       THEN 1
       WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
       THEN - 1
       WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
       THEN 1
       ELSE NULL
       END * V06.umrech_faktor AS NUMERIC), 6)
  ELSE NULL
  END AS menge_kg_tmp,
 V02.erfsngs_menge_einh_id,
  V02.menge_erf * CASE
   WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
   THEN 1
   WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
      V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
   THEN 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
   THEN 1
   ELSE NULL
   END AS menge_erf,
  CAST(CASE
    WHEN V07.basismenge_einh_id = 'KG'
    THEN V02.menge_lagerbew_bme * CASE
      WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
      THEN 1
      WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
      THEN - 1
      WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
      THEN 1
      WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
      THEN - 1
      WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
      THEN 1
      ELSE NULL
      END
    WHEN V07.basismenge_einh_id = 'ST'
    THEN ROUND(CAST(V02.menge_lagerbew_bme * CASE
         WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
         THEN 1
         WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
         THEN - 1
         WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
         THEN 1
         WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
         THEN - 1
         WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
         THEN 1
         ELSE NULL
         END * V06.umrech_faktor AS NUMERIC), 6)
    ELSE NULL
    END AS NUMERIC) * ROUND(CAST(V09.umrech_faktor AS NUMERIC), 3) AS menge_lagerbew_ame,
 V09.umrech_faktor,
 V08.dme_einh_id,
 V02.lagerort_id,
 V02.kostenstelle_id,
 V02.auftrag_id,
 V02.best_beleg_id,
 V02.best_beleg_pos_id,
  V02.menge_bestellpreis * CASE
   WHEN V02.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
   THEN 1
   WHEN V02.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR
      V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('309', '311') AND V02.soll_haben_kz = 'S'
   THEN 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'H'
   THEN - 1
   WHEN V02.lager_bewart_id IN ('310', '312') AND V02.soll_haben_kz = 'S'
   THEN 1
   ELSE NULL
   END AS menge_bestellpreis,
 V05.preis_steuer_kz,
 v10.pjwo,
 CAST(V11.nettopreis / V12.umrech_faktor AS NUMERIC) AS nettopreis,
 v14.menge_basis,
 v14.komponentenmenge
FROM kfl_production_dbp_view.v_flw_lagerbew_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_det_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.lagerbew_beleg_id
     = V02.lagerbew_beleg_id AND V01.kj = V02.kj
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_werk_1 AS V04 ON V02.werk_id = V04.werk_id AND V02.mandant_id = V04.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V02.flw_art_id
      = V05.flw_art_id AND V01.dat_buch BETWEEN V05.dat_von AND V05.dat_bis AND V04.werk_nr = V05.bewertungskreis_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_1 AS V07 ON V01.mandant_id = V07.mandant_id AND V02.flw_art_id = V07.flw_art_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V06 ON V02.flw_art_id = V06.flw_art_id AND V02.mandant_id
     = V06.mandant_id AND CASE
    WHEN V07.basismenge_einh_id = 'ST'
    THEN 'KG'
    WHEN V07.basismenge_einh_id = 'KG'
    THEN 'ST'
    ELSE NULL
    END = V06.altnv_menge_einh_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_wup_status_1 AS V08 ON V02.mandant_id = V08.mandant_id AND V02.werk_id = V08
    .werk_id AND V02.flw_art_id = V08.flw_art_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V09 ON V08.flw_art_id = V09.flw_art_id AND V08.mandant_id
     = V09.mandant_id AND V08.dme_einh_id = V09.altnv_menge_einh_id
 INNER JOIN (SELECT dat,
   pjwo
  FROM kfl_production_dbp_view.v_tag_1 AS V001
  GROUP BY dat,
   pjwo) AS v10 ON V01.dat_beleg = v10.dat
 LEFT JOIN kfl_production_dbp_msi_view_flw.mv_f_in_besch_best_det_1 AS V11 ON V02.mandant_id = V11.mandant_id AND V02.best_beleg_id
     = V11.best_beleg_id AND V02.best_beleg_pos_id = V11.best_beleg_pos_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_1 AS V12 ON V02.flw_art_id = V12.flw_art_id AND V02.mandant_id
     = V12.mandant_id AND V12.altnv_menge_einh_id = 'KG'
 LEFT JOIN kfl_production_dbp_view.v_flw_auftrag_pps_1 AS V13 ON V02.auftrag_id = V13.auftrag_id AND V02.mandant_id = V13
   .mandant_id
 LEFT JOIN (SELECT V010.mandant_id,
   V010.werk_id,
   V010.flw_art_id AS flw_art_id_out,
   V020.flw_art_id AS flw_art_id_in,
   V010.menge_basis,
   V020.komponentenmenge
  FROM kfl_production_dbp_view.v_flw_stueckliste_1 AS V010
   INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_det_1 AS V020 ON V010.mandant_id = V020.mandant_id AND V010.stueckliste_id
       = V020.stueckliste_id AND V010.stueckliste_typ_id = V020.stueckliste_typ_id
  WHERE V020.stueckliste_typ_id <> 'X'
   AND V020.komponentenmenge <> 0.001) AS v14 ON V02.mandant_id = v14.mandant_id AND V02.werk_id = v14.werk_id AND V02.flw_art_id
     = v14.flw_art_id_in AND V13.flw_art_id = v14.flw_art_id_out
WHERE V07.artikelart_id IN ('ZKMN', 'HALB', 'ZERL', 'ZFER', 'ROH', 'VERP', 'FERT', 'HAWA', 'ZDIE', 'REWO', 'ZHAW',
   'ZFLV')
 AND V01.mandant_id IN (1, 2);