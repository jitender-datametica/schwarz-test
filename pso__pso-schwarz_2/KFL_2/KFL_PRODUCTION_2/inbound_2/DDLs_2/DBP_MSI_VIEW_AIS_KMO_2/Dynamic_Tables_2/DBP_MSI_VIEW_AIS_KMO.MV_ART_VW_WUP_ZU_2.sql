CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_VW_WUP_ZU_2
(
 mandant_id
,wup_id
,vw_id
,art_id
,nb_id
,rabatt_zul_fg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   mandant_id,
   wup_id,
   vw_id,
   art_id,
   nb_id,
   rabatt_zul_fg
   FROM dbp_view.v_art_vw_wup_zu_2
   WHERE
   mandant_id <> 1
   AND wup_id = -1
   AND vw_id = 10;