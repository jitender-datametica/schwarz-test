CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WRG
(
wrg_id
, wrg_bez
)
AS
   SELECT
  wrg_id,
   wrg_bez
  FROM dbp_view.v_wrg;