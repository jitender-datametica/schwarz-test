create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WERBEWOCHE_KL_2(
	KJWO_WW,
	AKT_KJ,
	MANDANT_ID
) as
--2024-07-29, dknop, initial
SELECT DISTINCT kjwo_ww
,akt_wo
,mandant_id
FROM dbp_view.v_werbewoche_kl_2
JOIN dbp_view.v_woche_2
ON kjwo_ww = kjwo;