CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_WARTUNGSPLAN(
	MANDANT_ID,
	WART_PLAN_SORT_ID,
	WART_PLAN_BEZ,
	WART_PLAN_SORT_BEZ,
	WART_PLAN_ID
) AS
--2023-01-02,AP0153902_SPEC0181369, dknop, initial
SELECT
    mandant_id
   ,COALESCE(NULLIF(TRIM(wart_plan_sort_id ), ''),'-1') AS wart_plan_sort_id
   ,wart_plan_bez
   ,wart_plan_sort_id AS wart_plan_sort_bez
   ,wart_plan_id
FROM dbp_view.v_in_wartungsplan;