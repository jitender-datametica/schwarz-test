-- 31.05.2012 Einstandspreis hinzugefügt EK-2979807
 -- 31.05.2011
 -- Aufteilung von Umsatz, Absatz nach Kapazität

-- ,diff_netto_ums_konz
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_mo_sum_regalachse_1 (kjmo,
art_id, fbb_nr, fachboden_nr, fachboden_pos, bewart_id, mandant_id, wup_id, nb_id, gp_id, herst_id, ek_mep_umsatz,
umsatz_mwst_betrag, umsatz_netto, vk_menge, ek_netto4_absatz) AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 SELECT V01.kjmo,
 V01.art_id,
 V01.fbb_nr,
 V01.fachboden_nr,
 V01.fachboden_pos,
 V01.bewart_id,
 V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.gp_id,
 V01.herst_id,
   CASE
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_ek_mep_konz AS BIGNUMERIC)
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.ek_mep * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.ek_mep AS BIGNUMERIC)
   END * V01.kapazitaet_faktor AS ek_mep_umsatz,
   CASE
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
   END * V01.kapazitaet_faktor AS umsatz_mwst_betrag,
   CASE
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
   END * V01.kapazitaet_faktor AS umsatz_netto,
  CAST(V01.menge AS BIGNUMERIC) * V01.kapazitaet_faktor AS vk_menge,
   CASE
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 0
   THEN CAST(V01.diff_einstandspreis_konz AS BIGNUMERIC)
   WHEN V03.wrg_typ_id = 0 AND V03.berichtskurs_typ_id = 1
   THEN ROUND(CAST(V01.einstandspreis * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   ELSE CAST(V01.einstandspreis AS BIGNUMERIC)
   END * V01.kapazitaet_faktor AS ek_netto4_absatz
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_mo_sum_regalachse_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V03 ON TRUE;