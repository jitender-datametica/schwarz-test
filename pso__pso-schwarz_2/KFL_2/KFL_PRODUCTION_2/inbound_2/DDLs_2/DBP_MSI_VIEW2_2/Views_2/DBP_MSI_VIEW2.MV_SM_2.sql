CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_SM_2
(
sm_id,
sm_bez,
mandant_id,
spr_id
)
AS
   SELECT
  sm_id,
   sm_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_sm_2
   WHERE mandant_id=1
   AND sm_id <> -9;