CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_SM
-- 05.05.2014 twie: Lookup Sortimentsstufe

(
sm_id,
sm_bez,
mandant_id
)
AS
   SELECT
  sm_id,
   sm_bez,
   mandant_id

   FROM dbp_view.v_sm v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2)
   AND sm_id <> -9;