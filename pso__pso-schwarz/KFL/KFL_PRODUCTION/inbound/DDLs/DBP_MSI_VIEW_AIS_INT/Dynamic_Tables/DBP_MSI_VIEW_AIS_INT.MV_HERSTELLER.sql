CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_HERSTELLER
( herst_id
, herst_name
, mandant_id
, strasse
, plz
, ort
, land_id
, herst_fg
, ampel_flg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   g.gp_id,
   gp_name,
   mandant_id,
   gp_strasse,
   gp_plz,
   gp_ort,
   land_id,
   herst_fg,
   1
  FROM dbp_view.v_gp g

   WHERE herst_fg = 1;