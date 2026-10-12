CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_umbewertung_1 AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 SELECT V01.mandant_id,
 V01.umbew_beleg_id,
 V01.umbew_beleg_pos_id,
 V01.kj,
 V01.preis_aend_grund_id,
 V01.art_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_umbew,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.vk_brutto_alt, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.vk_brutto_alt, 0) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.vk_brutto_alt, 0) * V01.umrechnungskurs_1
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_alt,
 V01.menge_umbew,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_brutto, 0) * V01.umrechnungskurs_1
   ELSE NULL
   END AS NUMERIC) AS diff_wert_bestand_brutto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto, 0)
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN COALESCE(V01.diff_wert_bestand_netto, 0) * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN COALESCE(V01.diff_wert_bestand_netto, 0) * V01.umrechnungskurs_1
   ELSE NULL
   END AS NUMERIC) AS diff_wert_bestand_netto,
 V01.wrg_id,
 V01.menge_berechnet,
 V01.gp_id
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_art_umbewertung_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE;