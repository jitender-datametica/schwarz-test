CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_KL_WG_NIELSEN_GFK_HHP_WG_ZU
(
MANDANT_ID,
KL_WG_ID,
GFK_WG_ID
)
AS
SELECT
 mandant_id
,kl_wg_id
,gfk_wg_id
FROM dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu;