CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_QUARTAL_GJ_2(
	GJQU,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	GJHJ
) AS SELECT
    gjqu,
    akt_gjqu,
    akt_gjqu_komplett,
    gj,
    akt_gj,
    akt_gj_komplett,
    gjhj
FROM dbp_view.v_quartal_gj_2
WHERE gjqu > 200104;