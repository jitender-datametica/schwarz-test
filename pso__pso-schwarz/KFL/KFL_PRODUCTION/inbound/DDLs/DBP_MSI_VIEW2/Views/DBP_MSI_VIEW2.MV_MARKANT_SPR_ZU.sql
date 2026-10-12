CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_MARKANT_SPR_ZU
(
mandant_id
,markant_id
,markant_bez
)
AS 
SELECT 
mandant_id
,markant_id
,markant_bez
FROM dbp_view.v_markant_spr_zu
WHERE mandant_id = 1
AND spr_id = 22;