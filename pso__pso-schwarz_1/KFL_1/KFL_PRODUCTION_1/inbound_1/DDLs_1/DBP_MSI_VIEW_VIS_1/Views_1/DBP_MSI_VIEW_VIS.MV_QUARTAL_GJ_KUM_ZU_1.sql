CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_QUARTAL_GJ_KUM_ZU_1 as
   SELECT
   v01.gjqu AS gjqu_kum, v02.gjqu

   FROM dbp_view.v_monat_1 v01
   INNER JOIN dbp_view.v_monat_1 v02
   ON v01.akt_gjqu BETWEEN v02.akt_gjqu AND v02.akt_gjqu +3

   GROUP BY v01.gjqu, v02.gjqu;