CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_WERBEWOCHE_KL
--mcie1607, SPEC0066544, new view.
AS
SELECT 
mandant_id
,dat
,akt_kjwo_ww
,akt_kjwo_ww_komplett
,kjwo_ww
FROM dbp_view.v_werbewoche_kl
;