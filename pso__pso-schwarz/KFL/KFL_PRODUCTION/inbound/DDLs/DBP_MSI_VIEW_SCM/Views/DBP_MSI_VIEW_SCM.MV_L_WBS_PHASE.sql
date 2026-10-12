CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_l_wbs_phase
AS
   --AP0043130 | baranowska | initial creation
   SELECT
   mandant_id,
   wbs_phase_id
   FROM dbp_view.v_l_wbs_phase;