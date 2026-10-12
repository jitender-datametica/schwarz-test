CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_GFK_HHP_WG_2
(
MANDANT_ID,
GFK_WG_ID,
GFK_WG_BEZ
) 
AS
SELECT
 mandant_id
,gfk_wg_id
,gfk_wg_bez
FROM dbp_data.gfk_hhp_wg_2;