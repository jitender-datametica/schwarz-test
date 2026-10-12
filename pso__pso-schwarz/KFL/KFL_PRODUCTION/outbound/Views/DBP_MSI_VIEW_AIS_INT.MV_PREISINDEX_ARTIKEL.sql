CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_preisindex_artikel (mandant_id, dat_erfass, art_id, wrg_id
, betrag_umsatz_art, faktor_gewichtung_umsatz, preis_art_gewichtet_vorkalk, preis_art_gewichtet_nachkalk,
preis_art_vorkalk, preis_art_nachkalk, mkw_cd, kukla_id, dat_gueltig_von, dat_gueltig_bis, dat_vorkalk, dat_nachkalk,
preis_kukla_art_durchschnitt, preis_kukla_art_gewichtet, proz_schwellenwert, teurer_vk_flag, billiger_vk_flag,
gleich_vk_flag, teurer_nk_flag, billiger_nk_flag, gleich_nk_flag, diff_vk, diff_vk_proz, diff_nk, diff_nk_proz) AS
SELECT mandant_id,
 dat_erfass,
 art_id,
 wrg_id,
 betrag_umsatz_art,
 faktor_gewichtung_umsatz,
 preis_art_gewichtet_vorkalk,
 preis_art_gewichtet_nachkalk,
 preis_art_vorkalk,
 preis_art_nachkalk,
 mkw_cd,
 kukla_id,
 dat_gueltig_von,
 dat_gueltig_bis,
 dat_vorkalk,
 dat_nachkalk,
 preis_kukla_art_durchschnitt,
 preis_kukla_art_gewichtet,
 proz_schwellenwert,
  CASE
  WHEN preis_art_vorkalk > preis_kukla_art_durchschnitt
  THEN 'X'
  ELSE ''
  END AS teurer_vk_flag,
  CASE
  WHEN preis_art_vorkalk < preis_kukla_art_durchschnitt
  THEN 'X'
  ELSE ''
  END AS billiger_vk_flag,
  CASE
  WHEN preis_art_vorkalk = preis_kukla_art_durchschnitt
  THEN 'X'
  ELSE ''
  END AS gleich_vk_flag,
  CASE
  WHEN preis_art_nachkalk > preis_kukla_art_durchschnitt
  THEN 'X'
  ELSE ''
  END AS teurer_nk_flag,
  CASE
  WHEN preis_art_nachkalk < preis_kukla_art_durchschnitt
  THEN 'X'
  ELSE ''
  END AS billiger_nk_flag,
  CASE
  WHEN preis_art_nachkalk = preis_kukla_art_durchschnitt
  THEN 'X'
  ELSE ''
  END AS gleich_nk_flag,
  preis_art_vorkalk - preis_kukla_art_durchschnitt AS diff_vk,
  CASE
  WHEN preis_art_vorkalk IS NULL OR preis_art_vorkalk = 0
  THEN 0
  ELSE (preis_art_vorkalk - preis_kukla_art_durchschnitt) / preis_art_vorkalk
  END AS diff_vk_proz,
  preis_art_nachkalk - preis_kukla_art_durchschnitt AS diff_nk,
  CASE
  WHEN preis_art_nachkalk IS NULL OR preis_art_nachkalk = 0
  THEN 0
  ELSE (preis_art_nachkalk - preis_kukla_art_durchschnitt) / preis_art_nachkalk
  END AS diff_nk_proz
FROM kfl_production_dbp_data.preisindex_kukla_art;