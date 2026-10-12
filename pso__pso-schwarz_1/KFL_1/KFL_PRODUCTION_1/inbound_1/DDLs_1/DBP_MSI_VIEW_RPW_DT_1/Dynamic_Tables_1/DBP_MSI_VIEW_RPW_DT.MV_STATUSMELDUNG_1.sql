create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_STATUSMELDUNG_1(
	MANDANT_ID,
	STATUSMELDUNG_ID,
	ECM_VORGANG,
	ZEITSTEMPEL,
	DAT,
	DAT_ERFASST,
	DAT_BUCH,
	STATUSCODE_ID,
	URSPRUNG_BELEG_ID,
	URSPRUNG_BELEG_GJ,
	ERSTELLER_ID,
	GP_ID,
	GP_ID_LAST,
	EINKAUFSORGANISATION_ID,
	AUTO_FG,
	BETRAG_BRUTTO,
	BETRAG_MWST,
	WRG_ID,
	QUELLSYSTEM_ID,
	BELEGKLASSE_ID,
	SYSTEM_ID,
	FI_BELEG_ID,
	IMPRINT_NR,
	EDI_NR,
	BELEG_ID,
	BELEG_GJ,
	RPW_BELEG_ZU_ID,
	MANUELLE_BUCHUNG_FG,
	STATUSMELDUNG_ECM_LFD_NR,
	LAST_FG,
	WUP_ID,
	NB_ID,
	GP_LIEF_ID,
	DAT_BELEG,
	BETRAG_BRUTTO_RECH
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 06.07.2012 twie: wup_1 aus besch_rech_1 dazugejoint
-- 28.08.2013 kkai: besch_rech_1 wieder ausgebaut
-- 01.10.2013 twie: besch_rech_1 wieder eingebaut mit zusätzlichen Feldern

    SELECT
    v01.mandant_id,
    v01.statusmeldung_id,
    v01.ecm_vorgang,
    v01.zeitstempel,
    v01.dat,
    v01.dat_erfasst,
    v01.dat_buch,
    v01.statuscode_id,
    v01.ursprung_beleg_id,
    v01.ursprung_beleg_gj,
    v01.ersteller_id,
    v01.gp_id,
    v01.last_gp_id AS gp_id_last,
    v01.einkaufsorganisation_id,
    v01.auto_fg,
    v01.betrag_brutto,
    v01.betrag_mwst,
    v01.wrg_id,
    v01.quellsystem_id,
    v01.belegklasse_id,
    7,
    v01.fi_beleg_id,
    v01.imprint_nr,
    v01.edi_nr,
    v01.beleg_id,
    v01.beleg_gj,
    v01.beleg_id_orig AS rpw_beleg_zu_id,
    v01.manuelle_buchung_fg,
    v01.statusmeldung_ecm_lfd_nr,
    v01.last_fg,
    COALESCE(v02.wup_id, 0) AS wup_id,
    CASE
    WHEN v02.wup_id IS NULL THEN -1
    ELSE v02.nb_id
    END AS nb_id,
    v02.gp_lief_id,
    v02.dat_beleg,
    v02.betrag_brutto AS betrag_brutto_rech

FROM dbp_view.v_statusmeldung_1 v01
    LEFT OUTER JOIN dbp_view.v_besch_rech_1 v02
    ON v01.beleg_id = v02.rech_beleg_id
    AND v01.beleg_gj = v02.gj
    AND v01.mandant_id = v02.mandant_id

    WHERE v01.mandant_id = 1;
