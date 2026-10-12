CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wewa_row_1 (mandant_id, rech_beleg_id,
rech_beleg_kont_pos_id, wup_id, nb_id, gp_id, dat_buch, art_id, betrag_beleg, wewa_jahr, posten_kz_per) AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 SELECT V01.mandant_id,
 V01.rech_beleg_id,
 V01.rech_beleg_kont_pos_id,
 V01.wup_id,
 V01.nb_id,
 V01.gp_id,
 V01.dat_buch,
 V01.art_id,
 CAST(CASE
   WHEN V01.mandant_id_br = 5 AND V01.kursf_br < 0
   THEN V01.betrag_beleg_brk / ABS(V01.kursf_br)
   WHEN V200.wrg_typ_id = 1
   THEN V01.betrag_beleg_brk * V01.kursf_br
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
   THEN V01.betrag_beleg_brk * V01.kursf_br * V01.umrechnungskurs_0
   WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
   THEN V01.betrag_beleg_brk * V01.kursf_br * V01.umrechnungskurs_1
   ELSE NULL
   END AS BIGNUMERIC) AS betrag_beleg,
 V01.wewa_jahr,
 V01.posten_kz_per
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_wewa_row_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE;