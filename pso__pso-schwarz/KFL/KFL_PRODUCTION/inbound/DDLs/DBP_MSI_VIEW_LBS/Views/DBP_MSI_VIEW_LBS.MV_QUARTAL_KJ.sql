CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_QUARTAL_KJ(
	KJQU,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT
) AS SELECT
    kjqu,
    akt_kjqu,
    akt_kjqu_komplett,
    kj,
    akt_kj,
    akt_kj_komplett
FROM dbp_view.v_quartal_kj
WHERE kjqu>200104;