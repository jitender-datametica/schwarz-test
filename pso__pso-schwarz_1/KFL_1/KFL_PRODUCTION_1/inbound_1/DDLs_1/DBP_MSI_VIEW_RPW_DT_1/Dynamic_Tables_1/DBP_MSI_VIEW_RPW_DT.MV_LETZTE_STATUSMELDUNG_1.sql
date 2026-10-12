create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LETZTE_STATUSMELDUNG_1(
	LAST_FG,
	SYSTEM_ID,
	MANDANT_ID,
	STATUSMELDUNG_ID,
	BELEG_GJ,
	BELEG_ID,
	ZEITSTEMPEL,
	DAT,
	STATUSMELDUNG_ECM_LFD_NR,
	LETZTE_STATUSCODE_ID,
	ERSTELLER_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 05.09.2013 twie: belegklasse_id ausgeben
-- 01.10.2013 twie_ belegklasse_id wieder entfernt

    SELECT
    v01.last_fg,
    7,
    v01.mandant_id,
    v01.statusmeldung_id,
    v01.beleg_gj,
    v01.beleg_id,
    v01.zeitstempel,
    v01.dat,
    v01.statusmeldung_ecm_lfd_nr,
    v01.statuscode_id AS letzte_statuscode_id,
    v01.ersteller_id


FROM dbp_view.v_statusmeldung_1 v01
    WHERE v01.last_fg = 1
    AND v01.mandant_id = 1;
