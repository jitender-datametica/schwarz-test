CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_ALTERSTEILZEIT_SPR_ZU_HR_2
(
mandant_id
, atz_phase_id
, atz_bez
)
AS
   SELECT
   v01.mandant_id, v01.atz_phase_id, v01.atz_bez

   FROM dbp_view.v_altersteilzeit_spr_zu_2 v01
   WHERE v01.spr_id = 90
;