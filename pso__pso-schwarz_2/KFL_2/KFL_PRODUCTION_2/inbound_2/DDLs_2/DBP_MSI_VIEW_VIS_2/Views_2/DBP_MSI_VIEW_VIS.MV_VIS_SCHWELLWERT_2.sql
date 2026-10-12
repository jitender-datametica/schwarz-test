CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_SCHWELLWERT_2
(
mandant_id
,wup_id
,kjmo
,sw_thema_id
,sw_attribut_id
,sw_attribut_wert
,vis_schwellwert_2
)
AS
   SELECT
   mandant_id, wup_id, kjmo, sw_thema_id, sw_attribut_id, sw_attribut_wert, vis_schwellwert_2
   FROM dbp_view.v_vis_schwellwert_2;