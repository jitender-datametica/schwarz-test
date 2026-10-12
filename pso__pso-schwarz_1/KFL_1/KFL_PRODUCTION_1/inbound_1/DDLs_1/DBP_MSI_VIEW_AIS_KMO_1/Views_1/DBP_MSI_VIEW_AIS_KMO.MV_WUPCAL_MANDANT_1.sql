CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WUPCAL_MANDANT_1
-- Anzahl Bons ohne Marktberücksichtigung - schuecke 31.08.2015
-- INC1677419 - bonanzahl_sug added

(
  mandant_id
, dat
, bonanzahl
, bonanzahl_sug
)
AS
   SELECT
    mandant_id,
   dat,
   SUM(bonanzahl),
   SUM(bonanzahl_sug)
  FROM dbp_view.v_wupcal_1
  WHERE mandant_id <> 1
  GROUP BY
    mandant_id
  , dat;