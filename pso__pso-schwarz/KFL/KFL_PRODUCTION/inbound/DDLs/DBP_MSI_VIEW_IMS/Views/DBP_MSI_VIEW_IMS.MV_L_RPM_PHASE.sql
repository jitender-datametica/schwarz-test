CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_RPM_PHASE AS
-- 12.06.2013 twie: Lookup für RPM Status

   SELECT
   rpm_phase_id,
   rpm_projekt_typ_id
   FROM dbp_view.v_l_rpm_phase;