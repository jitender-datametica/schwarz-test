CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_SCHWELLWERT
(
mandant_id
,wup_id
,kjmo
,sw_thema_id
,sw_attribut_id
,sw_attribut_wert
,vis_schwellwert
)
AS
   SELECT
   mandant_id, wup_id, kjmo, sw_thema_id, sw_attribut_id, sw_attribut_wert, vis_schwellwert
   FROM dbp_view.v_vis_schwellwert;