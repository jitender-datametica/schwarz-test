CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_rech (system_id, mandant_id, rech_beleg_id, gj,
dat_erfasst, dat_rpw, dat_buch, dat_beleg, dat_rech_eingang, betrag_brutto, betrag_netto, referenzierung_fg,
dat_referenzierung, gp_lief_id, dat_leist_erstellung, gp_id_unbek_fg, forderung_unber_fg, dat_vorerfasst,
dat_aenderung_rpw, aenderung_user_name, gp_id, einkaufsorganisation_id, belegart_id, erfassung_id, ersteller_id, wup_id
, nb_id, buchungskreis_id, rech_beleg_storno_id, storno_gj, vorgangsart_ag08_id, rech_beleg_status_id,
betrag_diff_toleranz, bela_limit_unterschreitung_fg, bela_versandsperre_fg, bela_ref_beleg_id, bela_ref_gj,
bela_zahlsperre_id, buch_grund_int_id, buch_grund_ext_id, gs_ref_beleg_id, gs_ref_gj, anz_belege_gr_120,
anz_belege_90_120, anz_belege_60_89, anz_belege_30_59, anz_belege_15_29, anz_belege_kl_15, anz_belege_keine_buchung,
markant_archiv_nr, korrektur_kz, betrag_gp_fehler_netto, obj_id, betrag_beleg, betrag_korrektur_netto,
manuelle_buchung_fg, mengenabw_rpw_pos_anz, preisabw_rpw_pos_anz, mengenabw_rpw_fg, preisabw_rpw_fg, lieferschein_id_ext
, bestell_nr_ext, ocr_eingangskanal_id) AS SELECT 7 AS system_id,
 mandant_id,
 rech_beleg_id,
 gj,
 dat_vorerfasst AS dat_erfasst,
 DATE(CASE
   WHEN rech_beleg_status_id = '5'
   THEN dat_erfasst
   ELSE NULL
   END) AS dat_rpw,
 dat_buch,
 dat_beleg,
 dat_rech_eingang,
  ABS(betrag_brutto) * CASE
   WHEN belegart_id IN ('HS', 'HK', 'HB', '32')
   THEN 1
   ELSE - 1
   END AS betrag_brutto,
  ABS(betrag_netto) * CASE
   WHEN belegart_id IN ('HS', 'HK', 'HB', '32')
   THEN 1
   ELSE - 1
   END AS betrag_netto,
 referenzierung_fg,
 dat_referenzierung,
 gp_lief_id,
 dat_leist_erstellung,
 gp_id_unbek_fg,
 forderung_unber_fg,
 dat_vorerfasst,
 dat_aenderung_rpw,
 aenderung_user_name,
 gp_id,
 einkaufsorganisation_id,
 belegart_id,
 erfassung_id,
 ersteller_id,
 COALESCE(wup_id, 0) AS wup_id,
  CASE
  WHEN wup_id IS NULL
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE nb_id
  END AS nb_id,
 buchungskreis_id,
 COALESCE(CAST(rech_beleg_storno_id AS STRING), ' ') AS rech_beleg_storno_id,
 storno_gj,
 vorgangsart_ag08_id,
 rech_beleg_status_id,
 betrag_diff_toleranz,
 bela_limit_unterschreitung_fg,
 bela_versandsperre_fg,
 bela_ref_beleg_id,
 bela_ref_gj,
 bela_zahlsperre_id,
 CAST(COALESCE(buch_grund_int_id, '0') AS STRING) AS buch_grund_int_id,
 CAST(COALESCE(buch_grund_ext_id, '0') AS STRING) AS buch_grund_ext_id,
 gs_ref_beleg_id,
 gs_ref_gj,
  CASE
  WHEN rech_beleg_status_id = '5' AND DATE_DIFF(dat_buch, DATE(dat_erfasst), DAY) > 120
  THEN 1
  ELSE 0
  END AS anz_belege_gr_120,
  CASE
  WHEN rech_beleg_status_id = '5' AND DATE_DIFF(dat_buch, DATE(dat_erfasst), DAY) > 89 AND DATE_DIFF(dat_buch, DATE(dat_erfasst
      ), DAY) <= 120
  THEN 1
  ELSE 0
  END AS anz_belege_90_120,
  CASE
  WHEN rech_beleg_status_id = '5' AND DATE_DIFF(dat_buch, DATE(dat_erfasst), DAY) > 59 AND DATE_DIFF(dat_buch, DATE(dat_erfasst
      ), DAY) <= 89
  THEN 1
  ELSE 0
  END AS anz_belege_60_89,
  CASE
  WHEN rech_beleg_status_id = '5' AND DATE_DIFF(dat_buch, DATE(dat_erfasst), DAY) > 29 AND DATE_DIFF(dat_buch, DATE(dat_erfasst
      ), DAY) <= 59
  THEN 1
  ELSE 0
  END AS anz_belege_30_59,
  CASE
  WHEN rech_beleg_status_id = '5' AND DATE_DIFF(dat_buch, DATE(dat_erfasst), DAY) > 14 AND DATE_DIFF(dat_buch, DATE(dat_erfasst
      ), DAY) <= 29
  THEN 1
  ELSE 0
  END AS anz_belege_15_29,
  CASE
  WHEN rech_beleg_status_id = '5' AND DATE_DIFF(dat_buch, DATE(dat_erfasst), DAY) <= 14
  THEN 1
  ELSE 0
  END AS anz_belege_kl_15,
  CASE
  WHEN rech_beleg_status_id <> '5'
  THEN 1
  ELSE 0
  END AS anz_belege_keine_buchung,
 markant_archiv_nr,
  CASE
  WHEN mengenabw_rpw_pos_anz + preisabw_rpw_pos_anz <> 0
  THEN 'K'
  ELSE NULL
  END AS korrektur_kz,
  ABS(betrag_gp_fehler_netto) * CASE
   WHEN belegart_id IN ('HS', 'HK') AND (COALESCE(ROUND(SAFE_CAST(buch_grund_ext_id AS BIGNUMERIC), 0), 0) < 200 OR
         COALESCE(ROUND(SAFE_CAST(buch_grund_ext_id AS BIGNUMERIC), 0), 0) > 299) OR belegart_id IN ('32', 'HB') OR
      belegart_id = '31' AND COALESCE(ROUND(SAFE_CAST(buch_grund_ext_id AS BIGNUMERIC), 0), 0) BETWEEN 200 AND 299
   THEN 1
   ELSE - 1
   END AS betrag_gp_fehler_netto,
 obj_id,
 betrag_beleg,
 betrag_korrektur_netto,
 manuelle_buchung_fg,
 mengenabw_rpw_pos_anz,
 preisabw_rpw_pos_anz,
  CASE
  WHEN mengenabw_rpw_pos_anz > 0
  THEN 1
  ELSE 0
  END AS mengenabw_rpw_fg,
  CASE
  WHEN preisabw_rpw_pos_anz > 0
  THEN 1
  ELSE 0
  END AS preisabw_rpw_fg,
 lieferschein_id_ext,
 bestell_nr_ext,
 ocr_eingangskanal_id
FROM kfl_production_dbp_view.v_besch_rech AS RECH
WHERE mandant_id = 1;