CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_f_art_vz_bewkreis_monat_2 (mandant_id, wup_id, nb_id, art_id, gjmo
, preis_steuer_kz, wrg_id, gld, standard_preis, vz_menge_bestand_bme, vz_wert_bestand, vz_vk_wert) AS SELECT T1.mandant_id
 ,
 T2.wup_id,
 T2.nb_id,
 T1.art_id,
 T1.gjmo,
 T1.preis_steuer_kz,
 T1.wrg_id,
 T1.gld,
 T1.standard_preis,
 T1.menge_bestand_bme AS vz_menge_bestand_bme,
 T1.wert_bestand AS vz_wert_bestand,
 T1.vk_wert AS vz_vk_wert
FROM kfl_production_dbp_view.v_art_bewertungskreis_monat_2 AS T1_2
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS T2 ON T1.bewertungskreis_id = T2.bewertungskreis_id AND T1.mandant_id = T2
   .mandant_id
WHERE T2.nb_id = - 111
 AND T1.mandant_id = 1;