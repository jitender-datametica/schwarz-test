create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_LETZTE_ECM_STATUSMELDUNG_1(
	SYSTEM_ID,
	MANDANT_ID,
	STATUSMELDUNG_ID,
	BELEG_GJ,
	BELEG_ID,
	ZEITSTEMPEL,
	DAT,
	STATUSMELDUNG_ECM_LFD_NR,
	LETZTE_ECM_STATUSCODE_ID,
	ERSTELLER_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
--18.07.2012 twie: die letzte Statusmeldung_1 pro Beleg, im Gegensatz zum last_fg aber nur von ECM Vorgängen (mit Statuscode20xx)
-- bei 2 Datensätzen mit dem gleichen Zeitstempel wird der mit der höheren lfd. Nr. genommen
-- 30.08.2013 kkai: belegklasse_id mit augfenommen
-- 01.10.2013 twie_ belegklasse_id wieder entfernt

    SELECT

    7,
    v01.mandant_id,
    v01.statusmeldung_id,
    v01.beleg_gj,
    v01.beleg_id,
    v01.zeitstempel,
    v01.dat,
    v01.statusmeldung_ecm_lfd_nr,
    v01.statuscode_id AS letzte_ecm_statuscode_id,
    v01.ersteller_id

FROM dbp_view.v_statusmeldung_1 v01

    WHERE ecm_vorgang <> 0 --nur ECM Vorgängge mit 20xxer Codes
    AND beleg_gj <> 0 --Belege ohne GJ ausschließen
    AND beleg_id > 0  --negative Belege ausschließen
    AND v01.mandant_id = 1

    -- pro Beleg den Datensatz mit dem höchsten Zeitstempel, wenn identisch höchste lfd. Nr.
    QUALIFY ROW_NUMBER() OVER (PARTITION BY
    v01.mandant_id
    ,v01.beleg_gj
    ,v01.beleg_id
    ORDER BY v01.zeitstempel DESC NULLS LAST, statusmeldung_ecm_lfd_nr DESC NULLS LAST) =1
 ;
