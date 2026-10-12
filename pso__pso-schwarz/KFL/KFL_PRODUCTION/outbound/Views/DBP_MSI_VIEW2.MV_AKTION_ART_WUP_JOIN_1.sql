CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_aktion_art_wup_join_1 (aktion_id, mandant_id, dat_von, dat_bis,
dat, kjwo, vk_aktion_brutto, vk_vor_aktion_brutto, art_id, wup_id, nb_id, vk_brutto, aktionsart_id, sap_werbe_kat_id,
preisaktivierung, aktion_thema_id, werbe_kat_id) AS SELECT V01.aktion_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V03.dat,
 V03.kjwo,
 V02.vk_aktion_brutto,
 V02.vk_vor_aktion_brutto,
 V02.art_id,
 V02.wup_id,
 V02.nb_id,
 V06.vk_brutto,
 V01.aktionsart_id,
 V07.sap_werbe_kat_id,
  CASE
  WHEN V01.preisaktiviert_fg = 1
  THEN 'x'
  ELSE ' '
  END AS preisaktivierung,
 V02.aktion_thema_id,
 V07.werbe_kat_id
FROM kfl_production_dbp_view.v_aktion AS V01
 INNER JOIN kfl_production_dbp_view.v_aktion_art_wup_zu AS V02 ON V01.aktion_id = V02.aktion_id AND V01.mandant_id = V02
   .mandant_id
 INNER JOIN kfl_production_dbp_view.v_tag AS V03 ON V03.dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wup_zu_per AS V06 ON V02.art_id = V06.art_id AND V02.mandant_id = V06.mandant_id
       AND V02.wup_id = V06.wup_id AND V02.nb_id = V06.nb_id AND V03.dat BETWEEN V06.dat_von AND V06.dat_bis
 INNER JOIN kfl_production_dbp_view.v_l_werbekat AS V07 ON V01.werbe_kat_id = V07.werbe_kat_id
WHERE V02.grund_sperrung IS NULL
 AND V01.mandant_id = 1
 AND V03.akt_kj BETWEEN - 3 AND 0;