create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_MONAT_SPR_ZU_2(
	MO_GJ,
	MO_KJ,
	SPR_ID,
	MO_BEZ,
	KJMO,
	KJ,
	GJ,
	GJMO,
	MO_BEZ_LANG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    monat.mo_gj,
    TEXT.mo_id,
    TEXT.spr_id,
    TEXT.mo_bez,
    monat.kjmo,
    monat.kj,
    monat.gj,
    gjmo,
    TRIM(TEXT.mo_bez)|| ' ' ||TRIM(monat.kj),
    7
    FROM dbp_view.v_monat_spr_zu_2 TEXT
    INNER JOIN dbp_view.v_monat_2 monat_2
    ON TEXT.mo_id=monat.mo_kj
    AND spr_id=22
    AND kjmo >=200501
    AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);
