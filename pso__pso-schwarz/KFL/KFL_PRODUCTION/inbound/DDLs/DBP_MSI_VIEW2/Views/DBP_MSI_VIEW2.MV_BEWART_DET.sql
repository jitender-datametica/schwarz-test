CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BEWART_DET AS

SELECT 
bewart_det_id
,bewart_det_bez
FROM dbp_view.v_bewart_det_spr_zu
WHERE mandant_id = 1
AND spr_id = 22;