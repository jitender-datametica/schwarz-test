CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_RPM_PHASE_SPR_ZU_1 AS
-- 12.06.2013 twie: Sprachzuordnung für RPM Phase (Status_1)

   SELECT
   rpm_phase_id,
   rpm_projekt_typ_id,
   CASE WHEN rpm_phase_id = '1'
   THEN '' --Dummywert
   ELSE rpm_phase_bez
   END AS rpm_phase_bez
   FROM dbp_view.v_rpm_phase_spr_zu_1
   WHERE  spr_id=22;