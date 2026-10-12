CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WERBEWOCHE_KL(
	KJWO_WW,
    AKT_KJ,
	MANDANT_ID
) AS
--2024-07-29, dknop, initial
SELECT DISTINCT kjwo_ww
,akt_wo
,mandant_id
FROM dbp_view.v_werbewoche_kl
JOIN dbp_view.v_woche
ON kjwo_ww = kjwo;