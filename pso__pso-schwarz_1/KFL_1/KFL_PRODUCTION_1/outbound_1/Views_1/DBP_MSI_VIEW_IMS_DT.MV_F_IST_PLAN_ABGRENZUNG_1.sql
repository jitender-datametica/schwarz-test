CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_ist_plan_abgrenzung_1 (mandant_id, psp_id, gjmo,
dat_baubeginn, dat_beginn_einrichtung, dat_beginn_kaelte, dat_stille_eroeffnung, dat_bauabnahme,
anz_tage_massnahme_gesamt, anz_tage_massnahme_bis_gjmo, sparte_id, plan_abgrenzung_wert, plan_abgrenzung_wert_gesamt,
plan_abgrenzung_wert_bis_gjmo, betrag_ist_bis_gjmo) AS SELECT V01.mandant_id,
 V01.psp_id,
 V01.gjmo,
 V01.dat_baubeginn,
 V01.dat_beginn_einrichtung,
 V01.dat_beginn_kaelte,
 V01.dat_stille_eroeffnung,
 V01.dat_bauabnahme,
 V01.anz_tage_massnahme_gesamt,
 V01.anz_tage_massnahme_bis_gjmo,
 V01.sparte_id,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.plan_abgrenzung_wert_gesamt
  ELSE V01.plan_abgrenzung_wert_gesamt * V500.umrechnungskurs
  END AS plan_abgrenzung_wert,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.plan_abgrenzung_wert_gesamt
  ELSE V01.plan_abgrenzung_wert_gesamt * V500.umrechnungskurs
  END AS plan_abgrenzung_wert_gesamt,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.plan_abgrenzung_wert_bis_gjmo
  ELSE V01.plan_abgrenzung_wert_bis_gjmo * V500.umrechnungskurs
  END AS plan_abgrenzung_wert_bis_gjmo,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag_ist_bis_gjmo
  ELSE V01.betrag_ist_bis_gjmo * V500.umrechnungskurs
  END AS betrag_ist_bis_gjmo
FROM kfl_production_dbp_msi_view_ims_dt.tbl_mv_f_ist_plan_abgrenzung_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis;