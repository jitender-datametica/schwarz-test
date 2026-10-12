CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_art_wup_zu_per (mandant_id, wup_id, nb_id, dat,
art_id, bezugsweg_id, listung_id, plz_listung_id, vk_brutto, kdis, plz_kdis, wrg_id) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 T1.dat,
 V01.art_id,
 V01.bezugsweg_id,
 V01.listung_id,
 V03.listung_id AS plz_listung_id,
 V01.vk_brutto,
 V01.kdis,
 V03.kdis AS plz_kdis,
 V01.wrg_id
FROM kfl_production_dbp_view.v_art_wup_zu_per AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS T1 ON T1.dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
      AND V01.wup_id = V02.wup_id AND V02.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_wup_zu_per AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
      AND V01.wup_id = V03.wup_id AND DATE_SUB(T1.dat, INTERVAL CAST(ROUND(V02.planlieferzeit) AS INTEGER) DAY)
   BETWEEN V03.dat_von AND V03.dat_bis;