CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_MBEW_FG
(
mbew_fg
,mbew_fg_bez
)
AS

   SELECT
   '1' AS mbew_fg, CAST('MBEW' AS VARCHAR(5)) AS mbew_fg_bez
   FROM dbp_view.v_mandant
   WHERE mandant_id = 1

   UNION ALL

   SELECT
   '0' AS mbew_fg, CAST('MBEWH' AS VARCHAR(5)) AS mbew_fg_bez
   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;