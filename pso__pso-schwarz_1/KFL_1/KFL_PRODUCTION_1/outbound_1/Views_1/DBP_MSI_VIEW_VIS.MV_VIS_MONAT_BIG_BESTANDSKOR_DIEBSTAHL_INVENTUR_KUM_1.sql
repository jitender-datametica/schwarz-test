CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_big_bestandskor_diebstahl_inventur_kum_1 (kjmo,
mandant_id, wup_id, nb_id, art_id, wrg_id, bestandskorr_zvkp_vk_netto_kum, diebstahl_zvkp_vk_netto_kum,
inventurdiff_zvkp_vk_netto_kum, naturalrabatt_pl_vk_netto_kum) AS SELECT V00.kjmo,
 V00.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V00.nb_id,
 v01.art_id,
 V00.wrg_id,
 SUM(v01.bestandskorr_vk_netto) AS bestandskorr_zvkp_vk_netto_kum,
 SUM(v01.diebstahl_vk_netto) AS diebstahl_zvkp_vk_netto_kum,
 SUM(v01.inventurdiff_vk_netto) AS inventurdiff_zvkp_vk_netto_kum,
 SUM(v01.naturalrabatt_pl_vk_netto) AS naturalrabatt_pl_vk_netto_kum
FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_1 AS V00
 LEFT JOIN (SELECT T1.mandant_id,
   T1.lagerbew_beleg_id,
   T1.lagerbew_beleg_pos_id,
   T1.dat_buch,
   T11.dat_erfasst,
   COALESCE(t2.dat_plan_zaehlung_max, DATE '1900-01-01') AS dat_inventur,
   T1.art_id,
   T1.wrg_id,
   T1.wup_id,
   T1.nb_id,
   T1.lager_bewart_id,
   T1.auto_fg,
   T1.menge_lagerbew_bme,
   T1.betrag_vk_netto,
   T11.beleg_user_name,
   V05.mwst_id,
   V07.vk_brutto,
   V06.mwst,
     V07.vk_brutto * 100 / (100 + V06.mwst) AS vk_netto,
    CASE
    WHEN T1.lager_bewart_id IN ('343', '344') AND T11.beleg_user_name = 'VBATCH' AND T1.auto_fg = 'X' AND T1.dat_buch >
      COALESCE(t2.dat_plan_zaehlung_max, DATE '1900-01-01')
    THEN T1.menge_lagerbew_bme * (V07.vk_brutto * 100 / (100 + V06.mwst))
    ELSE 0
    END AS bestandskorr_vk_netto,
    CASE
    WHEN T1.lager_bewart_id IN ('993', '994', '190')
    THEN T1.menge_lagerbew_bme * (V07.vk_brutto * 100 / (100 + V06.mwst))
    ELSE 0
    END AS diebstahl_vk_netto,
    CASE
    WHEN T1.lager_bewart_id IN ('701', '702')
    THEN T1.menge_lagerbew_bme * (V07.vk_brutto * 100 / (100 + V06.mwst))
    ELSE 0
    END AS inventurdiff_vk_netto,
    CASE
    WHEN T1.lager_bewart_id IN ('951', '952') AND T1.mandant_id = 3
    THEN T1.menge_lagerbew_bme * (V07.vk_brutto * 100 / (100 + V06.mwst))
    ELSE 0
    END AS naturalrabatt_pl_vk_netto
  FROM kfl_production_dbp_view.v_lagerbew_det_1 AS T1_1
   INNER JOIN kfl_production_dbp_view.v_lagerbew_1 AS T11 ON T1.lagerbew_beleg_id = T11.lagerbew_beleg_id AND T1.dat_buch
      = T11.dat_buch AND T1.mandant_id = T11.mandant_id
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON T1.dat_buch = V02.dat
   LEFT JOIN (SELECT S1.mandant_id,
     S1.wup_id,
     S1.art_id,
     MAX(S1.dat_plan_zaehlung) AS dat_plan_zaehlung_max
    FROM kfl_production_dbp_view.v_inventur_termin_art_wup_zu_per_1 AS S1
     INNER JOIN kfl_production_dbp_view.v_tag_1 AS S2 ON S1.dat_plan_zaehlung = S2.dat
    WHERE S2.akt_mo BETWEEN - 12 AND (- 1)
    GROUP BY S1.mandant_id,
     S1.wup_id,
     S1.art_id) AS t2 ON T1.mandant_id = t2.mandant_id AND T1.wup_id = t2.wup_id AND T1.art_id = t2.art_id
   INNER JOIN kfl_production_dbp_view.v_art_1 AS V05 ON T1.art_id = V05.art_id AND T1.mandant_id = V05.mandant_id
   INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.mwst_id = V06.mwst_id
       AND V06.dat_bis = DATE '9999-12-31'
   INNER JOIN (kfl_production_dbp_view.v_art_wup_vk_per_1 AS V07 LEFT JOIN (SELECT MAX(dat) AS dat
     FROM kfl_production_dbp_view.v_tag_1
     WHERE akt_mo = - 1) AS t6 ON TRUE) ON V05.mandant_id = V07.mandant_id AND V05.art_id = V07.art_id AND T1.wup_id =
      V07.wup_id AND t6.dat BETWEEN V07.dat_von AND V07.dat_bis
  WHERE T1.mandant_id <> 1
   AND T1.lager_bewart_id IN ('343', '344', '341', '342', '993', '994', '190', '701', '702', '951', '952')
   AND V02.akt_mo BETWEEN - 12 AND (- 1)) AS v01 ON V00.mandant_id = v01.mandant_id AND V00.wup_id = v01.wup_id AND V00
   .wrg_id = v01.wrg_id
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V10 ON V00.kjmo = V10.kjmo AND V10.akt_mo = - 1
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V00.mandant_id = WUP.mandant_id AND V00.wup_id = WUP.wup_id
WHERE V00.mandant_id <> 1
GROUP BY V00.kjmo,
 V00.mandant_id,
 wup_id,
 V00.nb_id,
 v01.art_id,
 V00.wrg_id;