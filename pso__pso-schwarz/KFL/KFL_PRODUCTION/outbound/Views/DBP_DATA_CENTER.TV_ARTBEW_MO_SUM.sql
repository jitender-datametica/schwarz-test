CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_artbew_mo_sum AS SELECT T1.mandant_id,
 T2.kl_art_id AS art_id,
 T1.wup_id,
 T1.kjmo,
 SUM(T1.menge) AS menge1,
 SUM(T1.umsatz_netto) AS umsatz_netto1
FROM kfl_production_dbp_view.v_artbew_mo_sum AS T1
 INNER JOIN kfl_production_dbp_view.v_art AS T2 ON T1.art_id = T2.art_id AND T1.mandant_id = T2.mandant_id AND T2.dat_von
      <= CURRENT_DATE AND T2.dat_bis = DATE '9999-12-31' AND T1.bewart_id <> 1002
GROUP BY T1.mandant_id,
 art_id,
 T1.wup_id,
 T1.kjmo;