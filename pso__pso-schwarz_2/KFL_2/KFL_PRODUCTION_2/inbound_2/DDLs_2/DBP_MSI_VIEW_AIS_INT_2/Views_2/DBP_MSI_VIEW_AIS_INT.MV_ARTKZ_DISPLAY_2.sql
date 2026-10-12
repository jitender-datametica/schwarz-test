CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_DISPLAY_2 
( 
   display_id,
   display_bez,
   mandant_id,
   spr_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT   display_id,
   CASE
   WHEN display_id=0 THEN 'kein Displayartikel'
   ELSE display_bez
   END, mandant_id, spr_id
   FROM dbp_view.v_artkz_display_2
   WHERE mandant_id=1;