CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_aktion_art_wup_werbung_1 (aktion_id, mandant_id, kjwo, dat_von,
dat_bis, vk_aktion_brutto, art_id, wup_id, nb_id, aktionsart_id, aktion_thema_id) AS SELECT V01.aktion_id,
 V01.mandant_id,
 V03.kjwo,
 V01.dat_von,
 V01.dat_bis,
 V02.vk_aktion_brutto,
 V02.art_id,
 V05.aktuell_wup_id AS wup_id,
 V02.nb_id,
 V01.aktionsart_id,
 V02.aktion_thema_id
FROM kfl_production_dbp_view.v_aktion_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS V02 ON V01.aktion_id = V02.aktion_id AND V01.mandant_id = V02
   .mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V02.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS V03 ON V01.dat_von = V03.dat
WHERE V02.dat_sperrung IS NULL;