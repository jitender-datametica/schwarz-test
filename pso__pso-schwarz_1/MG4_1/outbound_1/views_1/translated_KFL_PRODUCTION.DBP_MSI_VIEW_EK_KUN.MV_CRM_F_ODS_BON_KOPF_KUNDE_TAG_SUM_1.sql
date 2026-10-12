CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_f_ods_bon_kopf_kunde_tag_sum_1 (mandant_id, wup_id, nb_id
, wrg_id, kundenkarte_id, crm_kundenkarte_art_id, crm_konto_id, crm_konto_typ_id, dat, kjwo_ww, anz_bons, ums_netto_sa,
ums_netto_af, ums_brutto_sa, ums_brutto_af, ums_netto, ums_brutto) AS SELECT k.mandant_id,
 k.wup_id,
 k.nb_id,
 k.wrg_id,
 k.kundenkarte_id,
 k.crm_kundenkarte_art_id,
 k.crm_konto_id,
 k.crm_konto_typ_id,
 k.dat,
 v03.kjwo_ww,
 SUM(k.anz_bons) AS anz_bons,
 SUM(CASE
   WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1, 5)
   THEN k.umsatz_netto_sa
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_netto_sa * v300.umrechnungskurs
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_netto_sa * v400.umrechnungskurs
   WHEN v02.wrg_typ_id = 1
   THEN k.umsatz_netto_sa
   ELSE NULL
   END) AS ums_netto_sa,
 SUM(CASE
   WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1, 5)
   THEN k.umsatz_netto_af
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_netto_af * v300.umrechnungskurs
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_netto_af * v400.umrechnungskurs
   WHEN v02.wrg_typ_id = 1
   THEN k.umsatz_netto_af
   ELSE NULL
   END) AS ums_netto_af,
 SUM(CASE
   WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1, 5)
   THEN k.umsatz_brutto_sa
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_brutto_sa * v300.umrechnungskurs
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_brutto_sa * v400.umrechnungskurs
   WHEN v02.wrg_typ_id = 1
   THEN k.umsatz_brutto_sa
   ELSE NULL
   END) AS ums_brutto_sa,
 SUM(CASE
   WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1, 5)
   THEN k.umsatz_brutto_af
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_brutto_af * v300.umrechnungskurs
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1, 5)
   THEN k.umsatz_brutto_af * v400.umrechnungskurs
   WHEN v02.wrg_typ_id = 1
   THEN k.umsatz_brutto_af
   ELSE NULL
   END) AS ums_brutto_af,
 SUM(CASE
   WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1, 5)
   THEN k.umsatz_netto_af + k.umsatz_netto_sa
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1, 5)
   THEN (k.umsatz_netto_af + k.umsatz_netto_sa) * v300.umrechnungskurs
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1, 5)
   THEN (k.umsatz_netto_af + k.umsatz_netto_sa) * v400.umrechnungskurs
   WHEN v02.wrg_typ_id = 1
   THEN k.umsatz_netto_af + k.umsatz_netto_sa
   ELSE NULL
   END) AS ums_netto,
 SUM(CASE
   WHEN v02.wrg_typ_id = 0 AND k.mandant_id IN (1, 5)
   THEN k.umsatz_brutto_af + k.umsatz_brutto_sa
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND k.mandant_id NOT IN (1, 5)
   THEN (k.umsatz_brutto_af + k.umsatz_brutto_sa) * v300.umrechnungskurs
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND k.mandant_id NOT IN (1, 5)
   THEN (k.umsatz_brutto_af + k.umsatz_brutto_sa) * v400.umrechnungskurs
   WHEN v02.wrg_typ_id = 1
   THEN k.umsatz_brutto_af + k.umsatz_brutto_sa
   ELSE NULL
   END) AS ums_brutto
FROM kfl_production_dbp_msi_view_ek_kun.tbl_mv_crm_f_ods_bon_kopf_kunde_tag_sum_1 AS k
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS v300 ON v300.dat_bis = DATE '9999-12-31' AND k.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3 AND v300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS v400 ON k.dat BETWEEN v400.dat_von AND v400.dat_bis AND k.wrg_id = v400.von_wrg_id
      AND v400.kurstyp_id = 3 AND v400.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS v02 ON TRUE
 LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS v03 ON k.dat = v03.dat AND k.mandant_id = v03.mandant_id
GROUP BY k.mandant_id,
 k.wup_id,
 k.nb_id,
 k.wrg_id,
 k.kundenkarte_id,
 k.crm_kundenkarte_art_id,
 k.crm_konto_id,
 k.crm_konto_typ_id,
 k.dat,
 v03.kjwo_ww;