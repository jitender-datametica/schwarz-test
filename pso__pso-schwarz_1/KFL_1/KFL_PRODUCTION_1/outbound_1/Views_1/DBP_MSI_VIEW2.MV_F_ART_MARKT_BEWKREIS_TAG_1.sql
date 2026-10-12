CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_f_art_markt_bewkreis_tag_1 (mandant_id, wup_id, nb_id, art_id, dat
, preis_steuer_kz, wrg_id, gld, gp_id, standard_preis, markt_menge_bestand_bme, markt_wert_bestand, markt_vk_wert) AS
SELECT T1.mandant_id,
 T2.wup_id,
 T2.nb_id,
 T1.art_id,
 T3.dat,
 T1.preis_steuer_kz,
 T1.wrg_id,
 T4.gp_id,
 T1.gld,
 T1.standard_preis,
 T1.menge_bestand_bme AS markt_menge_bestand_bme,
 T1.wert_bestand AS markt_wert_bestand,
 T1.vk_wert AS markt_vk_wert
FROM kfl_production_dbp_view.v_art_bewertungskreis_per_1 AS T1_1
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS T2 ON T1.bewertungskreis_id = T2.bewertungskreis_id AND T1.mandant_id = T2
   .mandant_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T3 ON T3.dat BETWEEN T1.dat_von AND T1.dat_bis AND T3.akt_tag <= 0
 INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_1 AS T4 ON T1.art_id = T4.art_id AND T1.mandant_id = T4.mandant_id AND
   T1.dat_von BETWEEN T4.dat_von AND T4.dat_bis
WHERE T1.mandant_id = 1
 AND T2.nb_id NOT IN (- 111, 99);