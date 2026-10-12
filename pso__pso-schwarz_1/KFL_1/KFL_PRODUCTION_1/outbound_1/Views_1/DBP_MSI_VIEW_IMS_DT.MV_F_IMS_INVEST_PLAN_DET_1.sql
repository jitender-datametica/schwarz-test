CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_ims_invest_plan_det_1 (mandant_id, gj, hochrechnung_fg,
berichts_pos_invest_grp_id, plan_betrag, psp_id, sparte_id) AS SELECT V01.mandant_id,
 V01.gj,
 V01.hr_plan_gesamt_kz AS hochrechnung_fg,
 V01.berichts_pos_invest_grp_id,
  CASE
  WHEN V100.wrg_typ_id = 1
  THEN V01.plan_betrag
  ELSE V01.plan_betrag * V300.umrechnungskurs
  END AS plan_betrag,
 V01.psp_id,
  CASE
  WHEN V01.sparte_id IN (4, 6, 8)
  THEN 5
  ELSE V01.sparte_id
  END AS sparte_id
FROM kfl_production_dbp_view.v_ims_invest_plan_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V100 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V300 ON V01.wrg_id = V300.von_wrg_id AND CURRENT_DATE BETWEEN V300.dat_von
     AND V300.dat_bis AND V200.kurstyp_id = V300.kurstyp_id AND V300.nach_wrg_id = 'EUR'
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V100.wrg_typ_id
    = V400.wrg_typ_id;