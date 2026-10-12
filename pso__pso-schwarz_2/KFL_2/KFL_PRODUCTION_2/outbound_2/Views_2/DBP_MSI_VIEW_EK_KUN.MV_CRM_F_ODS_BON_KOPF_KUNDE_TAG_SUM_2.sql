-- SPEC0055903, left outer CROSS JOIN to crm_l_konto_2

-- 24.03.2021 AP0076707, SPEC0093377, Pawel Staniszewski, add new field kjwo_ww

-- SPEC0072295, mcie1607, 12.03.2020, added CROSS JOIN by mandant_id with crm_l_kundenkarte_2

-- SPEC0055903, mcie1607, 12.12.2019, added anz_bons column
 -- SPEC0169673 wrg_2 changed to wrg_id

-- SPEC0066544, mcie1607, 06.04.2020, added left outer CROSS JOIN to mv_werbewoche_kl_2

-- SPEC0055903, mcie1607, taking umsatz from crm_kartebew.

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_f_ods_bon_kopf_kunde_tag_sum_2 AS
-- AP0202325/SPEC0292700 Umstellung auf akt. Berichtskurs (vorher Tageskurs) / sschuecke 04.02.2025

/* Umrechnung Landeswährung/Euro
JOIN KFL_PRODUCTION.dbp_view.v_kurs_2 kurs_2
    ON k.dat BETWEEN kurs.dat_von AND kurs.dat_bis
    AND k.wrg_id = kurs.von_wrg_id
    AND kurs.kurstyp_id = 9
    AND kurs.nach_wrg_id ='EUR' */
-- CROSS JOIN aktueller Berichtskurs
 SELECT K.mandant_id,
 K.wup_id,
 K.nb_id,
 K.wrg_id,
 K.kundenkarte_id,
 K.crm_kundenkarte_art_id,
 K.crm_konto_id,
 K.crm_konto_typ_id,
 K.dat,
 V03.kjwo_ww,
 SUM(K.anz_bons) AS anz_bons,
 SUM(CASE
   WHEN V02.wrg_typ_id = 0 AND K.mandant_id IN (1, 5)
   THEN K.umsatz_netto_sa
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_netto_sa * V300.umrechnungskurs
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_netto_sa * V400.umrechnungskurs
   WHEN V02.wrg_typ_id = 1
   THEN K.umsatz_netto_sa
   ELSE NULL
   END) AS ums_netto_sa,
 SUM(CASE
   WHEN V02.wrg_typ_id = 0 AND K.mandant_id IN (1, 5)
   THEN K.umsatz_netto_af
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_netto_af * V300.umrechnungskurs
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_netto_af * V400.umrechnungskurs
   WHEN V02.wrg_typ_id = 1
   THEN K.umsatz_netto_af
   ELSE NULL
   END) AS ums_netto_af,
 SUM(CASE
   WHEN V02.wrg_typ_id = 0 AND K.mandant_id IN (1, 5)
   THEN K.umsatz_brutto_sa
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_brutto_sa * V300.umrechnungskurs
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_brutto_sa * V400.umrechnungskurs
   WHEN V02.wrg_typ_id = 1
   THEN K.umsatz_brutto_sa
   ELSE NULL
   END) AS ums_brutto_sa,
 SUM(CASE
   WHEN V02.wrg_typ_id = 0 AND K.mandant_id IN (1, 5)
   THEN K.umsatz_brutto_af
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_brutto_af * V300.umrechnungskurs
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND K.mandant_id NOT IN (1, 5)
   THEN K.umsatz_brutto_af * V400.umrechnungskurs
   WHEN V02.wrg_typ_id = 1
   THEN K.umsatz_brutto_af
   ELSE NULL
   END) AS ums_brutto_af,
 SUM(CASE
   WHEN V02.wrg_typ_id = 0 AND K.mandant_id IN (1, 5)
   THEN K.umsatz_netto_af + K.umsatz_netto_sa
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND K.mandant_id NOT IN (1, 5)
   THEN (K.umsatz_netto_af + K.umsatz_netto_sa) * V300.umrechnungskurs
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND K.mandant_id NOT IN (1, 5)
   THEN (K.umsatz_netto_af + K.umsatz_netto_sa) * V400.umrechnungskurs
   WHEN V02.wrg_typ_id = 1
   THEN K.umsatz_netto_af + K.umsatz_netto_sa
   ELSE NULL
   END) AS ums_netto,
 SUM(CASE
   WHEN V02.wrg_typ_id = 0 AND K.mandant_id IN (1, 5)
   THEN K.umsatz_brutto_af + K.umsatz_brutto_sa
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND K.mandant_id NOT IN (1, 5)
   THEN (K.umsatz_brutto_af + K.umsatz_brutto_sa) * V300.umrechnungskurs
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND K.mandant_id NOT IN (1, 5)
   THEN (K.umsatz_brutto_af + K.umsatz_brutto_sa) * V400.umrechnungskurs
   WHEN V02.wrg_typ_id = 1
   THEN K.umsatz_brutto_af + K.umsatz_brutto_sa
   ELSE NULL
   END) AS ums_brutto
FROM kfl_production_dbp_msi_view_ek_kun.tbl_mv_crm_f_ods_bon_kopf_kunde_tag_sum_2 AS K
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V300 ON V300.dat_bis = DATE '9999-12-31' AND K.wrg_id = V300.von_wrg_id
   AND V300.kurstyp_id = 3 AND V300.nach_wrg_id = 'EUR' -- CROSS JOIN historischer Berichtskurs

 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V400 ON K.dat BETWEEN V400.dat_von AND V400.dat_bis AND K.wrg_id = V400.von_wrg_id
      AND V400.kurstyp_id = 3 AND V400.nach_wrg_id = 'EUR' -- Ermittlung eingestellte Währung

 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_2 AS V03 ON K.dat = V03.dat AND K.mandant_id = V03.mandant_id
GROUP BY K.mandant_id,
 K.wup_id,
 K.nb_id,
 K.wrg_id,
 K.kundenkarte_id,
 K.crm_kundenkarte_art_id,
 K.crm_konto_id,
 K.crm_konto_typ_id,
 K.dat,
 V03.kjwo_ww;