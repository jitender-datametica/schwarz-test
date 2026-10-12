CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_AUSSTATTUNG_2 as
   --  AL 09.04.2012 neu erstellt
   SELECT
   w.mandant_id, w.wup_id, ZEROIFNULL (SUM(CASE WHEN ausstattung_id = 3 THEN anzahl END)) AS  anz_mde_geraete, ZEROIFNULL (SUM(CASE WHEN ausstattung_id = 2 THEN anzahl  END)) AS  anz_kasse, ZEROIFNULL(SUM(CASE WHEN ausstattung_id = 4 THEN anzahl END)) AS anz_info_kasse, ZEROIFNULL(SUM(CASE WHEN ausstattung_id = 5 THEN anzahl END)) AS anz_leergut_kasse, CASE SUM(CASE WHEN ausstattung_id = 1 THEN anzahl END)
   WHEN NULL THEN -1
   WHEN 0 THEN 0
   ELSE 1
   END AS touchscreen_kz

   FROM dbp_msi_v_view.v_wup_denorm_2  w
   LEFT  JOIN dbp_view.v_ausstattung_wup_zu_per_2 a
   ON
   w.mandant_id =  a.mandant_id AND
   w.wup_id        =  a.wup_id AND
   a.dat_bis = '9999-12-31'

   GROUP BY w.mandant_id,
   w.wup_id;