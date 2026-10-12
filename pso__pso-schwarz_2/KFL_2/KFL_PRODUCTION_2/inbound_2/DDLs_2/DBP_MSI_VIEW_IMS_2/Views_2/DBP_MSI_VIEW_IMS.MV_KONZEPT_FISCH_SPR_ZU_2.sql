CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_KONZEPT_FISCH_SPR_ZU_2 AS
-- 17.06.2013 twie: Kopie aus VIS

   SELECT  t01.rpm_feld_auspr_id AS bed_fisch_id,
   CASE WHEN t01.rpm_feld_auspr_id = 1 THEN ''
   ELSE  t01. rpm_feld_auspr_bez
   END AS bed_fisch_bez
   FROM dbp_view.v_rpm_feld_auspr_spr_zu_2 t01
   INNER JOIN dbp_view.v_l_rpm_feld_2     t02
   ON t01.rpm_feld_id = t02.rpm_feld_id

   WHERE rpm_feld_bez='ZPPM_FISCH'
   AND rpm_tab_id=1
   AND spr_id=22;