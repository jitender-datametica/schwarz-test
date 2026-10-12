CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_JAHR_KJ_1(
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT
) AS SELECT
    kj,
    akt_kj,
    akt_kj_komplett
FROM dbp_view.v_jahr_kj_1
WHERE kj>2001;