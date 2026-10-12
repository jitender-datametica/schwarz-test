CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_RPM_PHASE_SPR_ZU_EN_2 AS
-- 12.06.2013 twie: Sprachzuordnung für RPM Phase (Status_2)
-- 27.06.2013 twie: wenn keine Landessprache (ls) vorhanden ist, de ausgeben

   SELECT
   de.rpm_phase_id,
   de.rpm_projekt_typ_id,
   CASE WHEN de.rpm_phase_id = '1'
   THEN '' --Dummywert
   ELSE COALESCE(ls.rpm_phase_bez , de.rpm_phase_bez )
   END AS rpm_phase_bez

   FROM dbp_view.v_rpm_phase_spr_zu_2   de
   LEFT OUTER JOIN
   (
   SELECT  rpm_phase_id,
   rpm_projekt_typ_id,
   rpm_phase_bez
  FROM dbp_view.v_rpm_phase_spr_zu_2
  WHERE spr_id = 24
  ) ls
   ON de.rpm_phase_id = ls.rpm_phase_id
   AND de.rpm_projekt_typ_id = ls.rpm_projekt_typ_id

   WHERE de.spr_id = 22;