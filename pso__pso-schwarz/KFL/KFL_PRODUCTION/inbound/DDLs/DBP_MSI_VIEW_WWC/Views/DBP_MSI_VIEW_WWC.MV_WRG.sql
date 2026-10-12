CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WRG
(
WAERS,
wrg_bez
)
AS
   SELECT
   wrg_id AS WAERS,
   wrg_bez
   FROM dbp_view.v_wrg;