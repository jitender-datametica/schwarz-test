CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_WG_BEZ_2
(
SPR_ID,
WG_ID,
WG_BEZ
)
AS
SELECT
spr_id,
wg_id,
MAX(wg_bez) wg_bez
FROM dbp_view.v_wg_spr_zu_2
GROUP BY 1,2;