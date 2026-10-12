CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_ladungstraeger_resb (mandant_id, reservierung_id,
reservierung_pos_id, dat_von, dat_bis, dat, erledigt_fg, art_id, wup_id, nb_id, dat_ausstellung, anz_ladungstraeger,
lager_bewart_id, dat_aenderung, bewegung_erlaubt_fg, spediteur_id, vk_brutto) AS SELECT V01.mandant_id,
 V01.reservierung_id,
 V01.reservierung_pos_id,
 V01.dat_von,
 V01.dat_bis,
 V03.dat,
 V01.erledigt_fg,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_ausstellung,
 V01.anz_ladungstraeger,
 V01.lager_bewart_id,
 V01.dat_aenderung,
 V01.bewegung_erlaubt_fg,
 V01.spediteur_id,
 v99.vk_brutto
FROM kfl_production_dbp_view.v_ladungstraeger_resb AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
   MAX(vk_brutto) AS vk_brutto
  FROM kfl_production_dbp_view.v_art_pm_vw_zu_per AS V02
  WHERE dat_bis = DATE '9999-12-31'
   AND art_id / 100 IN (9840018, 9840133, 9840042, 9840059, 9802554)
   AND (mandant_id = 1 AND preistyp_id = 0 AND pm_id IN (1, 10) AND vw_id IN (1, 2, 3) OR mandant_id <> 1 AND
         preistyp_id = 0 AND pm_id IN (1, 10) AND vw_id IN (10, 90))
  GROUP BY art_id,
   mandant_id) AS v99 ON V01.mandant_id = v99.mandant_id AND V01.art_id = v99.art_id
 INNER JOIN kfl_production_dbp_view.v_tag AS V03 ON V03.dat BETWEEN V01.dat_von AND V01.dat_bis AND V03.akt_kj > - 3 AND
   V03.dat <= CURRENT_DATE
WHERE EXTRACT(YEAR FROM V03.dat) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;