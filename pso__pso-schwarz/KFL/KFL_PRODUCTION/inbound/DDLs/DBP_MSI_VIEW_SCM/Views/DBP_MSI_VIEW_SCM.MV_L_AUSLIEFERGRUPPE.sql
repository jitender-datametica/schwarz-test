CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_AUSLIEFERGRUPPE (
	AUSLIEFERUNGSGRUPPE_ID,
	MANDANT_ID
)
--2026-01-20, dknop, initial
AS
SELECT auslieferungsgruppe_id, mandant_id FROM (
SELECT mandant_id, auslieferungsgruppe_id AS auslieferungsgruppe_id FROM dbp_view.v_wg_auslieferungsgruppe_per
UNION
SELECT mandant_id, ausliefergruppe_id FROM dbp_view.v_ts_wbs_ausliefergruppe ) a
GROUP BY auslieferungsgruppe_id, mandant_id

;