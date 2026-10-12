CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_f_art_markt_bewkreis_monat_2 (mandant_id, wup_id, nb_id, art_id,
gjmo, preis_steuer_kz, wrg_id, gld, standard_preis, markt_menge_bestand_bme, markt_wert_bestand, markt_vk_wert) AS
SELECT T1.mandant_id,
 T2.wup_id,
 T2.nb_id,
 T1.art_id,
 T1.gjmo,
 T1.preis_steuer_kz,
 T1.wrg_id,
 T1.gld,
 T1.standard_preis,
 T1.menge_bestand_bme AS markt_menge_bestand_bme,
 T1.wert_bestand AS markt_wert_bestand,
 T1.vk_wert AS markt_vk_wert
FROM kfl_production_dbp_view.v_art_bewertungskreis_monat_2 AS T1_2
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS T2 ON T1.bewertungskreis_id = T2.bewertungskreis_id AND T1.mandant_id = T2
   .mandant_id
WHERE T1.mandant_id = 1
 AND T2.nb_id NOT IN (- 111, 99);