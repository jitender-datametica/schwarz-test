CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BEWART_DET_2 AS

SELECT 
bewart_det_id
,bewart_det_bez
FROM dbp_view.v_bewart_det_spr_zu_2
WHERE mandant_id = 1
AND spr_id = 22;