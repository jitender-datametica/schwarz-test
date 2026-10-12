CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_stueckliste_zu_1 AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.dat,
 V01.komponente_art_id,
 V01.stueckliste_id,
 V01.wrg_id,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  END AS vks_umsatz_mwst_betrag,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
  END AS vks_umsatz_netto,
 CAST(V01.menge AS BIGNUMERIC) AS vks_vk_menge,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_brutto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_brutto AS BIGNUMERIC)
  END AS vks_ek_brutto_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto AS BIGNUMERIC)
  END AS vks_ek_netto_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_nettonetto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_nettonetto AS BIGNUMERIC)
  END AS vks_ek_netto2_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_mep AS BIGNUMERIC)
  END AS vks_ek_netto3_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.einstandspreis AS BIGNUMERIC)
  END AS vks_ek_netto4_absatz,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN ROUND(CAST(V01.ek_netto_bnk * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.ek_netto_bnk AS BIGNUMERIC)
  END AS vks_ek_nettobnk_absatz,
 V01.bq_findung_id,
 V01.umrechnungskurs
FROM kfl_production_dbp_data.artbew_stueckliste_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON (V01.mandant_id <> 5 OR V01.art_id <> 206731500)
      AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01.mandant_id <> 3 OR V01.art_id <> 208113690) AND (V01
       .mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id <> 208114740) AND (V01
     .mandant_id <> 8 OR V01.art_id <> 208131640)
WHERE V01.mandant_id <> 1;