CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_fur_best_vor AS SELECT V01.art_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_dispo,
 V01.gp_id,
 V01.menge_best_vor,
 ROUND(CAST(V01.menge_best_vor / CASE
     WHEN V04.umrech_faktor = 0
     THEN NULL
     ELSE V04.umrech_faktor
     END AS BIGNUMERIC), 5) AS menge_best_vor_bme,
 V01.dat_lief_soll,
 V03.dat_naechst_verkaufstag
FROM kfl_production_dbp_view.v_fur_best_vor AS V01
 INNER JOIN kfl_production_dbp_view.v_art AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
 LEFT JOIN kfl_production_dbp_view.v_art_wup_tag_denorm AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
      AND V01.wup_id = V03.wup_id AND V01.dat_lief_soll = V03.dat
 INNER JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS V04 ON V02.art_id = V04.art_id AND V02.mandant_id =
     V04.mandant_id AND V02.best_menge_einh_id = V04.altnv_menge_einh_id AND V01.dat_dispo BETWEEN V04.dat_von AND V04.dat_bis
   
WHERE V01.mandant_id = 1;