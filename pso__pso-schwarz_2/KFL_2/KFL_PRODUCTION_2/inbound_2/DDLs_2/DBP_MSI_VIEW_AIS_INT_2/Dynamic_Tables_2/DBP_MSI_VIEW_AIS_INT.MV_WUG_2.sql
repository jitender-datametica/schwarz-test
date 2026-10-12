CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WUG_2
(
mandant_id
,wg_id
,wug_id
,wgi_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id, v01.wg_id, v01.wug_id, CASE  WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END ||
   CASE WHEN v01.wug_id < 0 THEN TO_VARCHAR(v01.wug_id, 'FM000')
   ELSE TO_VARCHAR(v01.wug_id, 'FM000') END AS wgi_id

   FROM dbp_view.v_wug_2 v01;