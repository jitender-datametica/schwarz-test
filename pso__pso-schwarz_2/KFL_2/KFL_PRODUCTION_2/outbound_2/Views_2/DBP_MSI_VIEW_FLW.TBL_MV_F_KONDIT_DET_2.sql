CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_kondit_det_2 (mandant_id, kondition_id, konditionsart_id,
in_art_id, dat_bis, dat_von, dat, wrg_id_org, preisliste_typ_id, in_vw_id, art_id, default_wrg, betrag_kondition,
umrech_faktor) AS SELECT V01.mandant_id,
 V01.kondition_id,
 V01.konditionsart_id,
 V02.flw_art_id AS in_art_id,
 V02.dat_bis,
 V02.dat_von,
 T.dat,
 V02.wrg_id AS wrg_id_org,
 V02.preisliste_typ_id,
 V02.flw_vw_id AS in_vw_id,
 V04.art_id,
 V100.default_wrg,
 V01.betrag_kondition,
 V03.umrech_faktor
FROM kfl_production_dbp_view.v_flw_kondit_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kondit_freigabe_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.kondition_id
     = V02.kondition_id AND V01.konditionsart_id = V02.konditionsart_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.flw_art_id
     = V03.flw_art_id AND V01.kondition_menge_einh_id = V03.altnv_menge_einh_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_2 AS V04 ON V02.flw_art_id = V04.flw_art_id AND V02.mandant_id = V04.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON T.dat BETWEEN V02.dat_von AND V02.dat_bis;