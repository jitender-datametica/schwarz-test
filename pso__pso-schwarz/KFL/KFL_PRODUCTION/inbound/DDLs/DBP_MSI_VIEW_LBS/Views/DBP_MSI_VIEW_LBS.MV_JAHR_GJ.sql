CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_JAHR_GJ(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT
) AS SELECT
    gj,
    akt_gj,
    akt_gj_komplett
FROM dbp_view.v_jahr_gj
WHERE gj>2001;