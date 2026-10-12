CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_SM_1
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

   FROM dbp_view.v_sm_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id IN (1,2)
   AND sm_id <> -9;