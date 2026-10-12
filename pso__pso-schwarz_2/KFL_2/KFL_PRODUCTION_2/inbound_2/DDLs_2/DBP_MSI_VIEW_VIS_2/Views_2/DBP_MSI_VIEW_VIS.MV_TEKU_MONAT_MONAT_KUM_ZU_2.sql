CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_MONAT_MONAT_KUM_ZU_2 as
   SELECT
   kjmo, kjmo      AS kjmo_prompt, 1::BYTEINT     AS kum_id
   FROM dbp_view.v_monat_2
   WHERE gj >= 2012
   AND akt_gj <= 1

   UNION ALL

   SELECT
   t1.kjmo, t2.kjmo   AS kjmo_prompt, 2::BYTEINT     AS kum_id
   FROM dbp_view.v_monat_2 t1_2, dbp_view.v_monat_2 t2
   WHERE t1.gj = t2.gj
   AND t1.kjmo <= t2.kjmo
   AND t1.gj >= 2012
   AND t1.akt_gj <= 1
;