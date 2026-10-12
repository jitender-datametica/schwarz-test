CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_MELDUNGSART_WERK_ZU_1
-- 26.10.2011 system_id entfernt
(
mandant_id
--, system_id
, meldungsart_id
, werk_id
)
AS
   SELECT
   v01.mandant_id, v01.meldungsart_id, v01.werk_id

   FROM dbp_view.v_flw_meldungsart_werk_zu_1 v01;