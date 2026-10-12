CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_ALDI_2 (
ALDI_BEZ,
ALDI_ID,
MANDANT_ID,
SPR_ID
) AS
SELECT 
CASE WHEN aldi_bez='system generated' THEN 'kein_aldi' 
ELSE aldi_bez END, 
aldi_id, 
mandant_id, 
spr_id 
FROM dbp_view.v_artkz_aldi_2 
WHERE mandant_id = 1
UNION ALL
SELECT 
'X',
1,
mandant_id,
22 
FROM dbp_view.v_mandant_2 
WHERE mandant_id <> 1
UNION ALL
SELECT 
' ',
0,
mandant_id,
22
FROM dbp_view.v_mandant_2 
WHERE mandant_id <> 1; 