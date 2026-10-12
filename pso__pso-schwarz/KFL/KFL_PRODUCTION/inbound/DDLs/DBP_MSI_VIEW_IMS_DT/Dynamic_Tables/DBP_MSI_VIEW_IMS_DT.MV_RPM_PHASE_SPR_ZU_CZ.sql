CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_RPM_PHASE_SPR_ZU_CZ
(
	RPM_PHASE_ID,
	RPM_PROJEKT_TYP_ID,
	RPM_PHASE_BEZ
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS

-- 12.06.2013 twie: Sprachzuordnung für RPM Phase (Status)
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.rpm_phase_id,
   de.rpm_projekt_typ_id,
   CASE WHEN de.rpm_phase_id = '1'
   THEN '' --Dummywert
   ELSE COALESCE(ls.rpm_phase_bez , de.rpm_phase_bez )
   END AS rpm_phase_bez

   FROM dbp_view.v_rpm_phase_spr_zu   de
   LEFT OUTER JOIN
   (
   SELECT  rpm_phase_id,
   rpm_projekt_typ_id,
   rpm_phase_bez
  FROM dbp_view.v_rpm_phase_spr_zu
  WHERE spr_id = 124
  ) ls
   ON de.rpm_phase_id = ls.rpm_phase_id
   AND de.rpm_projekt_typ_id = ls.rpm_projekt_typ_id

   WHERE de.spr_id = 22
;