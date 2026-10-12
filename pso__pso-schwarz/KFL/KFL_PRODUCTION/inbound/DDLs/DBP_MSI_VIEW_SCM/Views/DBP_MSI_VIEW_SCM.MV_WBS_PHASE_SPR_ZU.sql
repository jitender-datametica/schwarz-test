CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_wbs_phase_spr_zu
AS
   --AP0043130 | baranowska | initial creation
   SELECT
   mandant_id,
   spr_id,
   wbs_phase_id,
   wbs_phase_bez
   FROM dbp_view.v_wbs_phase_spr_zu;