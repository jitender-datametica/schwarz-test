CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_wup_vk_aktionthema_markt (mandant_id, aktion_id, wup_id,
nb_id, art_id, vk_brutto) AS SELECT V01.mandant_id,
 V02.aktion_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.vk_brutto
FROM kfl_production_dbp_data.art_wup_vk_per AS V01
 INNER JOIN kfl_production_dbp_msi_view2.mv_aktionthema_markt AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id =
    V02.art_id AND V01.wup_id = V02.wup_id
WHERE V02.dat_von BETWEEN V01.dat_von AND V01.dat_bis
 AND V01.nb_id = 0;