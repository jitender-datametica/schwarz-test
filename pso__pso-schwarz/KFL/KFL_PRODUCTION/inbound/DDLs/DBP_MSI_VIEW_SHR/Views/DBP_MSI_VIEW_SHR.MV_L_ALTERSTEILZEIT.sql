CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_ALTERSTEILZEIT
(
mandant_id
, atz_phase_id
)
AS
   SELECT
   v01.mandant_id, v01.atz_phase_id

   FROM dbp_view.v_l_altersteilzeit v01;