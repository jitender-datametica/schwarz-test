CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_L_FEHLGRUND_1
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, fehlgrund_id
, fehlgrund_bez
)
AS
   SELECT
   v01.mandant_id, v01.fehlgrund_id, v01.fehlgrund_bez

   FROM dbp_view.v_flw_l_fehlgrund_1 v01;