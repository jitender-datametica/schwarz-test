CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_PM_WUP_ZU_2 as
   SELECT
   w.wup_id, w.mandant_id, w.nb_id, pm_fl_id, pm_og_id, pm_food_id, pm_nonfood_id, pm_wurst_bed_id, pm_sb_wurst_id, pm_kaese_bed_id
   FROM dbp_view.v_wup_2 w
   LEFT JOIN
   (
   SELECT
   wup_id, mandant_id, MAX(CASE WHEN wg_id IN (2)   THEN pm_id END) pm_fl_id, MAX(CASE WHEN wg_id IN (30)  THEN pm_id END) pm_og_id, MAX(CASE WHEN wg_id IN (250, 270, 280) THEN pm_id END) pm_food_id, MAX(CASE WHEN wg_id IN (550, 630) THEN pm_id END) pm_nonfood_id, MAX(CASE WHEN wg_id IN (10)  THEN pm_id END) pm_wurst_bed_id, MAX(CASE WHEN wg_id IN (12)  THEN pm_id END) pm_sb_wurst_id, MAX(CASE WHEN wg_id IN (350) THEN pm_id END) pm_kaese_bed_id
   FROM dbp_view.v_pm_wup_wg_zu_per_2

   WHERE dat_bis='9999-12-31' AND arthiertyp_id=2
   GROUP BY 1,2
   )  w_pm
   ON w.mandant_id = w_pm.mandant_id
   AND w.wup_id = w_pm.wup_id

   WHERE (w.nb_id IN (-2, -1, 0, 2, 6, 7) -- Filialen, zentralfilialen, Gastro, TKS
   AND w.dat_eroeffnung > to_date('1900-01-01','YYYY-MM_2-DD'))
   OR w.nb_id IN (-111,99)
   ;