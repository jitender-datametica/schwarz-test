CREATE OR REPLACE VIEW dbp_view.v_wbs_phase_zu_2
AS
   SELECT
   mandant_id,
ausliefergruppe_id,
anz_tage_vor_aktion,
wbs_phase_id,
TD_INSERT,
TD_UPDATE
   FROM dbp_data.wbs_phase_zu_2;