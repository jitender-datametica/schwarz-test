create or replace view DBP_ETL_PROCESS.V_ARTBEW_WG_SUM_AGG_WT_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	CALC_FG,
	DAT_LIEF,
	TD_UPDATE,
	TD_INSERT
) as
SELECT
*
FROM dbp_process.artbew_wg_sum_agg_wt_1;