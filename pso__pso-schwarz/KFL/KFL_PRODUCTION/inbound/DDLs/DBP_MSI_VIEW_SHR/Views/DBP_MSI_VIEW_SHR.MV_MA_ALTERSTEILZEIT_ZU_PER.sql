CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_ALTERSTEILZEIT_ZU_PER
(
mandant_id
, atz_phase_id
, mitarbeiter_id
, kjmo
)
AS
   SELECT
   v01.mandant_id, v01.atz_phase_id, v01.mitarbeiter_id, v01.kjmo

   FROM dbp_view.v_ma_altersteilzeit_zu_per v01
;