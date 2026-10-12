CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_plan AS SELECT PL.mandant_id,
 PL.plan_objekt_id AS flaeche_id,
 ZEIT.gj,
 PL.kjmo,
 PL.plandetail_id,
 PL.plantyp_id,
  PL.plan_wert * KURS.kurs AS planwert,
 KURS.wrg_id,
 KURS.wrg_typ_id
FROM kfl_production_dbp_view.v_ivs_plan AS PL
 INNER JOIN kfl_production_dbp_view.v_monat AS ZEIT ON PL.kjmo = ZEIT.kjmo AND ZEIT.akt_gj BETWEEN - 1 AND 0
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per AS KURS ON PL.mandant_id = KURS.mandant_id AND
   ZEIT.max_dat BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis;