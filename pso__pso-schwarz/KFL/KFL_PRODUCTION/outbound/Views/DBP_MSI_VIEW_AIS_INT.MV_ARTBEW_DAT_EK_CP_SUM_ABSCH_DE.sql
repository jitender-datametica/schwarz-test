CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artbew_dat_ek_cp_sum_absch_de (mandant_id, art_id,
bewart_id, bewart_det_id, wup_id, nb_id, dat, wrg_id, preis_abschrift_netto, posten_id_per, posten_kz_per) AS SELECT V01
 .mandant_id,
 V01.art_id,
 V01.bewart_id,
 V01.bewart_det_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat,
 V01.wrg_id,
 V01.preis_abschrift_netto,
  CASE
  WHEN V01.bewart_id = 1001 AND V02.posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN ''
  ELSE 'PN'
  END AS posten_id_per,
  CASE
  WHEN V02.posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'SO'
  ELSE 'PN'
  END AS posten_kz_per
FROM kfl_production_dbp_view.v_artbew_dat_ek_cp_sum AS V01
 LEFT JOIN kfl_production_dbp_view.v_art_per AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id AND
   V01.dat BETWEEN DATE_SUB(V02.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V02.dat_bis, INTERVAL 1 DAY))
WHERE V01.wup_bereinigt_fg = 0
 AND V01.mandant_id = 1;