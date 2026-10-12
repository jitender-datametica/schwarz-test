CREATE OR REPLACE VIEW dbp_view.v_l_wbs_phase_2
AS
   SELECT
   mandant_id,
wbs_phase_id,
TD_INSERT,
TD_UPDATE
   FROM dbp_data.l_wbs_phase_2;