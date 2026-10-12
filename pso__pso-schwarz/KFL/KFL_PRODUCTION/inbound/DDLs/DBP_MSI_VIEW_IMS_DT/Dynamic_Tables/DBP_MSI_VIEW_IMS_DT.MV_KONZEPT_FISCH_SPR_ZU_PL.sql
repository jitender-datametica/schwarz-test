CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_KONZEPT_FISCH_SPR_ZU_PL
(
	BED_FISCH_ID,
	BED_FISCH_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 17.06.2013 twie: Kopie aus VIS
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben
-- 20.08.2013/Gia

   SELECT
   de1.rpm_feld_auspr_id AS bed_fisch_id,
   CASE WHEN de1.rpm_feld_auspr_id = 1 THEN ''
   ELSE  COALESCE(ls.rpm_feld_auspr_bez, de1.rpm_feld_auspr_bez)
   END AS bed_fisch_bez

   FROM dbp_view.v_rpm_feld_auspr_spr_zu  de1
   INNER JOIN dbp_view.v_l_rpm_feld     de2
   ON de1.rpm_feld_id = de2.rpm_feld_id
   LEFT OUTER JOIN
   (
   SELECT ls1.rpm_feld_auspr_id,
   ls1.rpm_feld_auspr_bez
  FROM dbp_view.v_rpm_feld_auspr_spr_zu ls1
   INNER JOIN dbp_view.v_l_rpm_feld     ls2
   ON ls1.rpm_feld_id = ls2.rpm_feld_id
   WHERE ls1.spr_id = 90
   AND  ls2.rpm_feld_bez='ZPPM_FISCH'
   AND ls1.rpm_tab_id=1
   ) ls
   ON de1.rpm_feld_auspr_id = ls.rpm_feld_auspr_id

   WHERE de1.spr_id = 22
   AND  de2.rpm_feld_bez='ZPPM_FISCH'
   AND de1.rpm_tab_id=1
;