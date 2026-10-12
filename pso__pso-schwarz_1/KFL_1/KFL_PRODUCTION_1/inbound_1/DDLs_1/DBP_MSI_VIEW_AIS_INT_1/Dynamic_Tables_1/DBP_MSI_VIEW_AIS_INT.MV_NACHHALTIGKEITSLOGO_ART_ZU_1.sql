CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_NACHHALTIGKEITSLOGO_ART_ZU_1
(
mandant_id
,art_id
,nachhaltigkeitslogo_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
  mandant_id, art_id, nachhaltigkeitslogo_id
   FROM dbp_view.v_nachhaltigkeitslogo_art_zu_1

   UNION ALL

   SELECT
   mandant_id, art_id, -999
   FROM dbp_view.v_art_1
   MINUS
   SELECT
   mandant_id, art_id, -999 FROM dbp_view.v_nachhaltigkeitslogo_art_zu_1;