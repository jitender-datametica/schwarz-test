CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WERBEWOCHE_KL
(
mandant_id
,dat
,akt_kjwo_ww
,akt_kjwo_ww_komplett
,kjwo_ww
,wo_ww
)
AS
   SELECT
   mandant_id, dat, akt_kjwo_ww, akt_kjwo_ww_komplett, kjwo_ww, kjwo_ww AS wo_ww
   FROM dbp_view.v_werbewoche_kl;