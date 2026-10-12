create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LETZTE_PROBLEMMELDUNG(
	LAST_FG,
	SYSTEM_ID,
	MANDANT_ID,
	PROBLEMMELDUNG_ID,
	BELEG_GJ,
	BELEG_ID,
	DAT,
	PROBLEMMELDUNG_ECM_LFD_NR,
	LETZTE_PROBLEMCODE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                            SELECT
                            v01.last_fg,
                            7,
                            v01.mandant_id,
                            v01.problemmeldung_id,
                            v01.beleg_gj,
                            v01.beleg_id,
                            v01.dat,
                            v01.problemmeldung_ecm_lfd_nr,
                            v01.problemcode_id AS letzte_problemcode_id

                            FROM dbp_view.v_problemmeldung v01
                            WHERE v01.last_fg = 1
                            AND v01.mandant_id = 1;
