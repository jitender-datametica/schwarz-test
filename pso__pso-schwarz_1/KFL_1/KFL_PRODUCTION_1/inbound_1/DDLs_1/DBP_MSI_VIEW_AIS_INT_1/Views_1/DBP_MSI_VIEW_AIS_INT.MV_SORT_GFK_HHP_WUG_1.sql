CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_GFK_HHP_WUG_1
(
MANDANT_ID,
GFK_WG_ID,
GFK_WUG_ID,
GFK_WG_BEZ,
GFK_WUG_BEZ
)
AS
SELECT
 v01.mandant_id
,v01.gfk_wg_id
,v01.gfk_wug_id
,v02.gfk_wg_bez
,v01.gfk_wug_bez
FROM dbp_data.gfk_hhp_wug_1 v01
JOIN dbp_data.gfk_hhp_wg_1 v02
ON v01.gfk_wg_id = v02.gfk_wg_id
AND v01.mandant_id = v02.mandant_id;