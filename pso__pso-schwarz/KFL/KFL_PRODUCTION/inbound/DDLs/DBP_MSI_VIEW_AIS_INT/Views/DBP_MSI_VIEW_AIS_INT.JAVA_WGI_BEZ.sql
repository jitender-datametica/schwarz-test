CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_WGI_BEZ
(
SPR_ID,
WG_ID,
WUG_ID,
WGI_BEZ
) 
AS
SELECT
spr_id,
wg_id,
wug_id,
MAX(wug_bez) wgi_bez
FROM dbp_view.v_wug_spr_zu
GROUP BY 1,2,3;