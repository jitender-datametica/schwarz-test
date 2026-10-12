CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_VERKAUFSSPERRE_FG_1
(
verkauf_sperre_fg
,verkauf_sperre_fg_bez
)
AS

   SELECT
   CAST(1 AS BYTEINT) AS verkauf_sperre_fg, CAST('Verkaufssperre' AS VARCHAR(20)) AS verkauf_sperre_fg_bez
   FROM dbp_view.v_mandant_1
   WHERE mandant_id = 1

   UNION ALL

   SELECT
   CAST(0 AS BYTEINT) AS verkauf_sperre_fg, CAST('keine Verkaufssperre' AS VARCHAR(20)) AS verkauf_sperre_fg_bez
   FROM dbp_view.v_mandant_1
   WHERE mandant_id = 1;