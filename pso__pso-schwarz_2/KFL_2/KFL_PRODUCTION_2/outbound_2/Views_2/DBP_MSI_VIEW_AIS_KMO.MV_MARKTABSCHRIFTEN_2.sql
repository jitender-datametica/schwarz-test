-- AL 22.03.2012 Anpassung INNER JOIN auf LEFT JOIN bei art_gp_nm_zu_per_2

-- Awol 13.03.13: Where Bedingung von "v01.abschriftart_id BETWEEN 933 AND 994" auf "v01.abschriftart_id BETWEEN 905 AND 994" geändert. S. Mail Frau Winter 11.03.13

-- AL  26.03.2012 Teilen Menge durch 1000 bei Gewichtsartikel (in der Beladung wird mit 1000 multipliziert)

-- Awol 21.06.12: CROSS JOIN auf bei art_gp_nm_zu_per_2 angepasst. AND v01.mandant_id = v02.mandant_id

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_marktabschriften_2 (mandant_id, wup_id, wup_abschrift_id,
positionsnummer, abschriftart_id, nb_id, dat, woche_id, absch_menge, art_id, lastupd_dat, abschriftbetrag_netto,
abschriftbetrag_brutto, gp_id, posten_kz_per) AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 SELECT V01.mandant_id,
 V01.wup_id,
 V01.wup_abschrift_id,
 V01.positionsnummer_id AS positionsnummer,
 V01.abschriftart_id,
 V01.nb_id,
 V01.dat,
 V01.woche_id,
   CASE
   WHEN V01.gewart_id = 'KG'
   THEN CAST(V01.menge_abschrift AS NUMERIC) / 1000
   ELSE CAST(V01.menge_abschrift AS NUMERIC)
   END * - 1 AS absch_menge,
 V01.art_id,
 V01.lastupd_dat,
  CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_netto, 0)
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN COALESCE(V01.abschriftbetrag_netto, 0) * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_netto, 0) * V01.umrechnungskurs_1
    ELSE NULL
    END AS NUMERIC) * - 1 AS abschriftbetrag_netto,
  CAST(CASE
    WHEN V200.wrg_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_brutto, 0)
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN COALESCE(V01.abschriftbetrag_brutto, 0) * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN COALESCE(V01.abschriftbetrag_brutto, 0) * V01.umrechnungskurs_1
    ELSE NULL
    END AS NUMERIC) * - 1 AS abschriftbetrag_brutto,
 COALESCE(V01.gp_id, - 1) AS gp_id,
 -- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
 V01.posten_kz_per
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_marktabschriften_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE;