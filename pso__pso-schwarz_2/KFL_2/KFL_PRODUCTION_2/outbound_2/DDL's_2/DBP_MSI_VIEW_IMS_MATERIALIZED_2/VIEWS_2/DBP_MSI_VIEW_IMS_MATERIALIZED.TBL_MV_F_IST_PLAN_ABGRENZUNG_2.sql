CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.tbl_mv_f_ist_plan_abgrenzung_2 (mandant_id, psp_id,
gjmo, dat_baubeginn, dat_beginn_einrichtung, dat_beginn_kaelte, dat_stille_eroeffnung, dat_bauabnahme,
anz_tage_massnahme_gesamt, anz_tage_massnahme_bis_gjmo, sparte_id, plan_abgrenzung_wert_gesamt,
plan_abgrenzung_wert_bis_gjmo, betrag_ist_bis_gjmo, wrg_id) AS SELECT V01.mandant_id,
 V01.psp_id,
 V01.gjmo,
 V01.dat_baubeginn,
 V01.dat_beginn_einrichtung,
 V01.dat_beginn_kaelte,
 V01.dat_stille_eroeffnung,
 V01.dat_bauabnahme,
 V01.anz_tage_massnahme_gesamt,
 V01.anz_tage_massnahme_bis_gjmo,
  CASE
  WHEN V04.sparte_id IN (4, 6, 8)
  THEN 5
  ELSE V04.sparte_id
  END AS sparte_id,
 V01.plan_abgrenzung_wert_gesamt,
 V01.plan_abgrenzung_wert_bis_gjmo,
 V01.betrag_ist_bis_gjmo,
 V01.wrg_id
FROM kfl_production_dbp_msi_v_view.v_ims_plan_abgrenzung_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_psp_element_2 AS V02 ON V01.psp_id = V02.psp_id AND V01.mandant_id = V02.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_in_projekt_2 AS V03 ON V02.in_projekt_id = V03.in_projekt_id AND V02.mandant_id =
   V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_ims_standort_2 AS V04 ON V03.standort_id = V04.standort_id AND V03.mandant_id = V04
   .mandant_id;