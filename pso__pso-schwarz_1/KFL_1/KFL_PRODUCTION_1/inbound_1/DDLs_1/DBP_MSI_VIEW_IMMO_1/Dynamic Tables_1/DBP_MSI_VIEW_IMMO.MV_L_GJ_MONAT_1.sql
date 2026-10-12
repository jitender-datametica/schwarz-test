CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_GJ_MONAT_1(
	GJMO,
	GJMO_VJ,
	GJQU,
	GJ,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	MO_GJ,
	MIN_DAT,
	MAX_DAT
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
   SELECT
   gjmo, gjmo_vj, gjqu, gj, akt_mo, akt_mo_komplett, akt_gjqu, akt_gjqu_komplett, akt_gj, akt_gj_komplett, mo_gj, min_dat, max_dat
   FROM dbp_view.v_monat_1;