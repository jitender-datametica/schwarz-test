CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_wup_nachschub_per_2 AS SELECT V01.mandant_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.menge_bestand_soll_max,
 V02.sollbestand,
 V02.min_sicherh_bestand,
 V03.dat
FROM kfl_production_dbp_view.v_art_wup_nachschub_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
     AND V01.wup_id = V02.wup_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS V03 ON V03.dat BETWEEN V02.dat_von AND V02.dat_bis AND V03.dat BETWEEN V01
   .dat_von AND V01.dat_bis
WHERE V03.akt_kj >= - 3;