CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ZSM_ART_SPR_ZU
(
INT_ART_ID,
MANDANT_ID,
ART_BEZ
)
AS
SELECT
 v02.int_art_id
,v01.mandant_id
,v01.art_bez
FROM DBP_VIEW.V_ART_SPR_ZU v01
JOIN DBP_VIEW.V_ART v02
ON  v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
WHERE v01.spr_id = 22
AND v01.mandant_id = 1;