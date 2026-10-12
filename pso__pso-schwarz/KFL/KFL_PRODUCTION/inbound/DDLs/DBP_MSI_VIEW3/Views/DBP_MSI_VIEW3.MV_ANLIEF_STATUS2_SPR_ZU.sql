CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ANLIEF_STATUS2_SPR_ZU
(
anlieferung_status2_id
,anlieferung_status2_bez
)
AS
-- 20230717 staeblern Umstellung auf Session Variable 
   SELECT
   v01.anlieferung_status2_id, v01.anlieferung_status2_bez
   FROM dbp_view.v_anlieferung_status2_spr_zu v01
   INNER JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02
   ON v01.spr_id = v02.spr_id
   ;