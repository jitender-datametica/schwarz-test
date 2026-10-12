create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_SOLL_HABEN(
	SOLL_HABEN_KZ,
	MANDANT_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    'S' AS soll_haben_kz,
    mandant_id
FROM dbp_view.v_mandant
WHERE mandant_id = 1

UNION ALL

SELECT
'H' AS soll_haben_kz,
    mandant_id
FROM dbp_view.v_mandant
WHERE mandant_id = 1;
