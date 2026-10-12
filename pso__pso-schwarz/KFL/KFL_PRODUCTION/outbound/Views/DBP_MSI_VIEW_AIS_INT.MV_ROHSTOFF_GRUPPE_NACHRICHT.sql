CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rohstoff_gruppe_nachricht (rohstoffkategorie,
nachricht_typ_id, spr_id, sprache, nachricht_titel_txt, nachricht_inhalt_txt, trend_typ_id, dat_trend_von,
prognose_halbjahr_typ_id, nachricht_link_txt, preis_reduzierende_faktoren_txt, preis_steigernde_faktoren_txt,
forecast_txt, dat_gueltig_von, dat_gueltig_bis) AS SELECT rohstoff_kategorie_kfl_name AS rohstoffkategorie,
 nachricht_typ_id,
 spr_id,
  CASE
  WHEN spr_id = 22
  THEN 'Deutsch'
  WHEN spr_id = 24
  THEN 'Englisch'
  ELSE NULL
  END AS sprache,
 nachricht_titel_txt,
 nachricht_inhalt_txt,
 trend_typ_id,
 dat_trend_von,
 prognose_halbjahr_typ_id,
 nachricht_link_txt,
 preis_reduzierende_faktoren_txt,
 preis_steigernde_faktoren_txt,
 forecast_txt,
 dat_gueltig_von,
 dat_gueltig_bis
FROM kfl_production_dbp_msi_data.ts_rohstoff_monitoring_nachricht AS V01
WHERE CURRENT_DATE BETWEEN dat_gueltig_von AND dat_gueltig_bis;