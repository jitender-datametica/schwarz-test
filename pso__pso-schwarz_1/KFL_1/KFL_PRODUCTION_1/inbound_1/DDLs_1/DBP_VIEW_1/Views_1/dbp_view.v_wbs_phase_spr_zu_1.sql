CREATE OR REPLACE VIEW dbp_view.v_wbs_phase_spr_zu_1
AS
   SELECT
   mandant_id,
spr_id,
wbs_phase_id,
wbs_phase_bez,
TD_INSERT,
TD_UPDATE
   FROM dbp_data.wbs_phase_spr_zu_1;