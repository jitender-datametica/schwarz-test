CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_POSTEN
(
mandant_id
, posten_id
, posten_bez
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   v01.mandant_id, v01.posten_id, v01.posten_bez

   FROM dbp_view.v_artkz_posten v01;