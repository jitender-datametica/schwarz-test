CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_regalachse (art_id, fbb_nr, fachboden_nr,
fachboden_pos, bewart_id, dat, ek_mep_umsatz, gp_id, herst_id, mandant_id, mwst_id, nb_id, umsatz_mwst_betrag,
umsatz_netto, vk_menge, wrg, wup_id, bezugsweg_id, aktion_id) AS SELECT V01.art_id,
 V03.fbb_nr,
 V03.fachboden_nr,
 V03.fachboden_pos,
 V01.bewart_id,
 V01.dat,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.ek_mep AS BIGNUMERIC)
   END * V03.kapazitaet_faktor AS ek_mep_umsatz,
 V01.gp_id,
 V01.herst_id,
 V01.mandant_id,
 V01.mwst_id,
 V01.nb_id,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
   END * V03.kapazitaet_faktor AS umsatz_mwst_betrag,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
   END * V03.kapazitaet_faktor AS umsatz_netto,
  CAST(V01.menge AS BIGNUMERIC) * V03.kapazitaet_faktor AS vk_menge,
 V01.wrg,
 V01.wup_id,
 V01.bezugsweg_id,
 V01.aktion_id
FROM kfl_production_dbp_view.v_artbew AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V02 ON V01.mandant_id <> 5 OR V01.art_id <> 206731500
 INNER JOIN kfl_production_dbp_view.v_regalachse_akt AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
      AND V01.wup_id = V03.wup_id AND V01.nb_id = V03.nb_id
WHERE V01.mandant_id <> 1
 AND V03.mandant_id <> 1;