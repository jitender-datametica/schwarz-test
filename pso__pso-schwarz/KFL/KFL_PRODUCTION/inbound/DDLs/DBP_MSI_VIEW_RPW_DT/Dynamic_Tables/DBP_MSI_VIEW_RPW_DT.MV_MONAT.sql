create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_MONAT(
	KJMO,
	KJMO_VJ,
	GJMO,
	GJMO_VJ,
	KJQU,
	GJQU,
	KJ,
	GJ,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	MO_GJ,
	MO_KJ,
	KJMO_DAT_VON,
	KJMO_DAT_BIS,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    m.kjmo,
    m.kjmo_vj,
    m.gjmo,
    m.gjmo_vj,
    m.kjqu,
    m.gjqu,
    m.kj,
    m.gj,
    m.akt_mo,
    m.akt_mo_komplett,
    m.akt_gjqu,
    m.akt_gjqu_komplett,
    m.akt_kjqu,
    m.akt_kjqu_komplett,
    m.akt_gj,
    m.akt_gj_komplett,
    m.akt_kj,
    m.akt_kj_komplett,
    m.mo_gj,
    m.mo_kj,
    MIN(t.dat) AS kjmo_dat_von,
    MAX(t.dat) AS kjmo_dat_bis,
    7
    FROM dbp_view.v_monat m
    INNER JOIN dbp_view.v_tag t
    ON m.kjmo = t.kjmo

    WHERE m.kjmo >= 200501
    AND m.kj <= EXTRACT(YEAR FROM CURRENT_DATE)
    
    GROUP BY
    m.kjmo
    ,m.kjmo_vj
    ,m.gjmo
    ,m.gjmo_vj
    ,m.kjqu
    ,m.gjqu
    ,m.kj
    ,m.gj
    ,m.akt_mo
    ,m.akt_mo_komplett
    ,m.akt_gjqu
    ,m.akt_gjqu_komplett
    ,m.akt_kjqu
    ,m.akt_kjqu_komplett
    ,m.akt_gj
    ,m.akt_gj_komplett
    ,m.akt_kj
    ,m.akt_kj_komplett
    ,m.mo_gj
    ,m.mo_kj;
