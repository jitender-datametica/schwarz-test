CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lieferant_grp_sort_2 (in_lief_grp_id,
in_lief_grp_mandant_id, in_lief_id, mandant_id, hawa_we_mege_kg, histo_we_mege_kg, histo_we_wert, rohst_we_wert,
rohst_we_menge_kg) AS SELECT CASE
  WHEN L.mandant_id = 2 AND L.flw_lief_id_cz > 0
  THEN L.flw_lief_id_cz
  ELSE L.flw_lief_id
  END AS in_lief_grp_id,
  CASE
  WHEN L.mandant_id = 2 AND L.flw_lief_id_cz > 0
  THEN 1
  ELSE L.mandant_id
  END AS in_lief_grp_mandant_id,
 L.flw_lief_id AS in_lief_id,
 L.mandant_id,
 SUM(IFNULL(v0.hawa_we_mege_kg, 0)) AS hawa_we_mege_kg,
 SUM(IFNULL(v0.histo_we_mege_kg, 0)) AS histo_we_mege_kg,
 SUM(IFNULL(v0.histo_we_wert, 0)) AS histo_lwe_wert,
 SUM(IFNULL(v0.rohst_we_wert, 0)) AS rohst_we_wert,
 SUM(IFNULL(v0.rohst_we_menge_kg, 0)) AS rohst_we_menge_kg
FROM kfl_production_dbp_view.v_flw_lieferant_2 AS L
 LEFT JOIN (SELECT V04.mandant_id,
   V01.flw_lief_id,
   SUM(CASE
     WHEN V12.hauptgruppe_id = 'HAWA'
     THEN CASE
      WHEN V03.best_menge_einh_id = 'KG'
      THEN V04.menge_lagerbew_bme * CASE
        WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
          )
        THEN 1
        WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
           ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
        THEN - 1
        WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
        THEN 1
        WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
        THEN - 1
        WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
        THEN 1
        ELSE NULL
        END
      WHEN V11.altnv_menge_einh_id = 'KG'
      THEN ROUND(CAST(V04.menge_lagerbew_bme * CASE
           WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
           THEN 1
           WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
           THEN - 1
           WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
           THEN 1
           WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
           THEN - 1
           WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
           THEN 1
           ELSE NULL
           END * V11.umrech_faktor AS NUMERIC), 6)
      ELSE NULL
      END
     ELSE NULL
     END) AS hawa_we_mege_kg,
   SUM(CASE
     WHEN V12.hauptgruppe_id = 'HISTO'
     THEN CASE
      WHEN V03.best_menge_einh_id = 'KG'
      THEN V04.menge_lagerbew_bme * CASE
        WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
          )
        THEN 1
        WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
           ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
        THEN - 1
        WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
        THEN 1
        WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
        THEN - 1
        WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
        THEN 1
        ELSE NULL
        END
      WHEN V11.altnv_menge_einh_id = 'KG'
      THEN ROUND(CAST(V04.menge_lagerbew_bme * CASE
           WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
           THEN 1
           WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
           THEN - 1
           WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
           THEN 1
           WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
           THEN - 1
           WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
           THEN 1
           ELSE NULL
           END * V11.umrech_faktor AS NUMERIC), 6)
      ELSE NULL
      END
     ELSE NULL
     END) AS histo_we_mege_kg,
   SUM(CASE
     WHEN V12.hauptgruppe_id = 'HISTO'
     THEN CASE
      WHEN V07.preis_steuer_kz = 'V'
      THEN CASE
       WHEN V04.wrg_id <> 'EUR'
       THEN V04.betrag_lagerbew * CASE
          WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531',
            'Y30')
          THEN 1
          WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532',
             'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
          THEN 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
          THEN 1
          ELSE NULL
          END * V500.umrechnungskurs
       ELSE V04.betrag_lagerbew * CASE
         WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
           )
         THEN 1
         WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
            ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
         THEN 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
         THEN 1
         ELSE NULL
         END
       END
      WHEN V07.preis_steuer_kz = 'S'
      THEN CASE
       WHEN V04.wrg_id <> 'EUR'
       THEN V04.betrag_lagerbew_altnv * CASE
          WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531',
            'Y30')
          THEN 1
          WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532',
             'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
          THEN 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
          THEN 1
          ELSE NULL
          END * V500.umrechnungskurs
       ELSE V04.betrag_lagerbew_altnv * CASE
         WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
           )
         THEN 1
         WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
            ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
         THEN 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
         THEN 1
         ELSE NULL
         END
       END
      ELSE NULL
      END
     ELSE NULL
     END) AS histo_we_wert,
   SUM(CASE
     WHEN V12.hauptgruppe_id NOT IN ('HISTO', 'HAWA')
     THEN CASE
      WHEN V07.preis_steuer_kz = 'V'
      THEN CASE
       WHEN V04.wrg_id <> 'EUR'
       THEN V04.betrag_lagerbew * CASE
          WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531',
            'Y30')
          THEN 1
          WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532',
             'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
          THEN 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
          THEN 1
          ELSE NULL
          END * V500.umrechnungskurs
       ELSE V04.betrag_lagerbew * CASE
         WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
           )
         THEN 1
         WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
            ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
         THEN 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
         THEN 1
         ELSE NULL
         END
       END
      WHEN V07.preis_steuer_kz = 'S'
      THEN CASE
       WHEN V04.wrg_id <> 'EUR'
       THEN V04.betrag_lagerbew_altnv * CASE
          WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531',
            'Y30')
          THEN 1
          WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532',
             'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
          THEN 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
          THEN - 1
          WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
          THEN 1
          ELSE NULL
          END * V500.umrechnungskurs
       ELSE V04.betrag_lagerbew_altnv * CASE
         WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
           )
         THEN 1
         WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
            ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
         THEN 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
         THEN - 1
         WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
         THEN 1
         ELSE NULL
         END
       END
      ELSE NULL
      END
     ELSE NULL
     END) AS rohst_we_wert,
   SUM(CASE
     WHEN V12.hauptgruppe_id NOT IN ('HISTO', 'HAWA')
     THEN CASE
      WHEN V03.best_menge_einh_id = 'KG'
      THEN V04.menge_lagerbew_bme * CASE
        WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30'
          )
        THEN 1
        WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29'
           ) OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
        THEN - 1
        WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
        THEN 1
        WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
        THEN - 1
        WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
        THEN 1
        ELSE NULL
        END
      WHEN V11.altnv_menge_einh_id = 'KG'
      THEN ROUND(CAST(V04.menge_lagerbew_bme * CASE
           WHEN V04.lager_bewart_id IN ('101', '501', '521', '202', '162', '262', '552', '602', '644', '912', '531', 'Y30')
           THEN 1
           WHEN V04.lager_bewart_id IN ('102', '502', '522', '201', '161', '261', '551', '601', '643', '911', '532', 'Y29') OR V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'H'
           THEN - 1
           WHEN V04.lager_bewart_id IN ('309', '311') AND V04.soll_haben_kz = 'S'
           THEN 1
           WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'H'
           THEN - 1
           WHEN V04.lager_bewart_id IN ('310', '312') AND V04.soll_haben_kz = 'S'
           THEN 1
           ELSE NULL
           END * V11.umrech_faktor AS NUMERIC), 6)
      ELSE NULL
      END
     ELSE NULL
     END) AS rohst_we_menge_kg
  FROM kfl_production_dbp_view.v_flw_pruef_los_2 AS V01
   INNER JOIN kfl_production_dbp_view.v_flw_besch_best_det_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.best_beleg_id
       = V03.best_beleg_id AND V01.best_beleg_pos_id = V03.best_beleg_pos_id
   INNER JOIN kfl_production_dbp_view.v_flw_besch_best_2 AS V03A ON V03.best_beleg_id = V03A.best_beleg_id AND V03.mandant_id
      = V03A.mandant_id
   INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_det_2 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.best_beleg_id
       = V04.best_beleg_id AND V03.best_beleg_pos_id = V04.best_beleg_pos_id
   INNER JOIN kfl_production_dbp_view.v_flw_lagerbew_2 AS V05 ON V04.mandant_id = V05.mandant_id AND V04.lagerbew_beleg_id
        = V05.lagerbew_beleg_id AND V04.kj = V05.kj AND V05.vorgangsart_id = 'WE'
   INNER JOIN kfl_production_dbp_view.v_flw_werk_2 AS V06 ON V04.werk_id = V06.werk_id AND V04.mandant_id = V06.mandant_id
     
   INNER JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per_2 AS V07 ON V04.mandant_id = V07.mandant_id AND V04.flw_art_id
        = V07.flw_art_id AND V06.werk_nr = V07.bewertungskreis_id AND V05.dat_buch BETWEEN V07.dat_von AND V07.dat_bis
   INNER JOIN kfl_production_dbp_view.v_flw_art_2 AS V10 ON V03.mandant_id = V10.mandant_id AND V03.flw_art_id = V10.flw_art_id
     
   INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V500.kurstyp_id = 3 AND V04.wrg_id = V500.von_wrg_id AND V500.nach_wrg_id
       = 'EUR' AND V05.dat_buch BETWEEN V500.dat_von AND V500.dat_bis
   LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_2 AS V11 ON V10.flw_art_id = V11.flw_art_id AND V10.mandant_id
       = V11.mandant_id AND 'KG' = V11.altnv_menge_einh_id
   INNER JOIN kfl_production_dbp_view.v_flw_produktgruppe_2 AS V12 ON V10.produktgruppe_id = V12.produktgruppe_id AND V10
     .mandant_id = V12.mandant_id
  WHERE V05.dat_buch BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)
   AND V01.mandant_id IN (1, 2)
   AND V03A.einkaufsorganisation_id IN (5000, 5013, 5014)
  GROUP BY V04.mandant_id,
   V01.flw_lief_id) AS v0 ON L.mandant_id = v0.mandant_id AND L.flw_lief_id = v0.flw_lief_id
WHERE L.mandant_id IN (1, 2)
GROUP BY in_lief_grp_id,
 in_lief_grp_mandant_id,
 in_lief_id,
 L.mandant_id;