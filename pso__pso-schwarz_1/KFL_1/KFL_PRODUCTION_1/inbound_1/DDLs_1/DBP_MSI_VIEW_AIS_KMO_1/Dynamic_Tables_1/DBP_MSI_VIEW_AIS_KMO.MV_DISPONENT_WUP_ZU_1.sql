CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_DISPONENT_WUP_ZU_1
(
 mandant_id
,wup_id
,nb_id
,disponent_id
,disponent_name
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   mandant_id,
   wup_id,
   nb_id,
   disponent_id,
   disponent_name

   FROM dbp_view.v_disponent_wup_zu_1
   WHERE mandant_id <> 1
   -- 20100330 Filterung der IWT Betriebe
   AND nb_id <> 99;