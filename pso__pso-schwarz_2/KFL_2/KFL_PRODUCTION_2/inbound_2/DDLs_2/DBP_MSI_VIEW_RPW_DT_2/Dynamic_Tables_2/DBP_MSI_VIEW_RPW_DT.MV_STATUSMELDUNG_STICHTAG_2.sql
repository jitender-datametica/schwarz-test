create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_STATUSMELDUNG_STICHTAG_2(
	STATUSMELDUNG_ID,
	SYSTEM_ID,
	MANDANT_ID,
	IMPRINT_NR,
	BELEG_ID,
	BELEG_GJ,
	ECM_VORGANG,
	ZEITSTEMPEL,
	DAT_ERFASST,
	DAT_BUCH,
	DAT_BELEG,
	STATUSCODE_ID,
	URSPRUNG_BELEG_ID,
	URSPRUNG_BELEG_GJ,
	ERSTELLER_ID,
	GP_ID,
	EINKAUFSORGANISATION_ID,
	AUTO_FG,
	BETRAG_BRUTTO,
	BETRAG_MWST,
	WRG_ID,
	QUELLSYSTEM_ID,
	BELEGKLASSE_ID,
	BELEG_ALTER,
	BELEG_ALTER_ID,
	ABTEILUNG_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
   SELECT
   sm.statusmeldung_id,
   7,
   sm.mandant_id,
   sm.imprint_nr,
   sm.beleg_id,
   sm.beleg_gj,
   sm.ecm_vorgang,
   sm.zeitstempel,
   sm.dat_erfasst,
   sm.dat_buch,
   CAST(zeitstempel AS DATE) AS dat_beleg,
   sm.statuscode_id,
   sm.ursprung_beleg_id,
   sm.ursprung_beleg_gj,
   sm.ersteller_id,
   sm.gp_id,
   sm.einkaufsorganisation_id,
   sm.auto_fg,
   sm.betrag_brutto,
   sm.betrag_mwst,
   sm.wrg_id,
   sm.quellsystem_id,
   sm.belegklasse_id,
   subsel.beleg_alter,
   CASE WHEN subsel.beleg_alter  BETWEEN 0 AND 15 THEN 1 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 15 AND  30 THEN 2 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 31 AND  59 THEN 3 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 60 AND  89 THEN 4 ELSE
CASE WHEN subsel.beleg_alter BETWEEN 90 AND  120 THEN  5 ELSE 6 END
END
END
END
END AS beleg_alter_id,
   ergzp.abteilung_id


FROM dbp_view.v_statusmeldung_2 sm_2

   JOIN (
   SELECT
   br.rech_beleg_id,
   br.gj,
   br.mandant_id,
   br.dat_vorerfasst,
   MAX(sm.statusmeldung_id) AS statusmeldung_id,
   CAST(MAX(sm.zeitstempel) AS DATE) AS dat_letzter_statuscode,
   (CURRENT_DATE - br.dat_vorerfasst) AS beleg_alter
   FROM dbp_view.v_besch_rech_2 br
   JOIN dbp_view.v_statusmeldung_2 sm_2
   ON br.rech_beleg_id   =sm.beleg_id
   AND br.gj          =sm.beleg_gj
   AND br.mandant_id  =sm.mandant_id
   AND br.rech_beleg_status_id IN ('A', 'B')
   AND br.belegart_id IN ('HS','HK', 'IS', 'IK')

   GROUP BY 1,2,3,4

   ) subsel
   ON subsel.rech_beleg_id = sm.beleg_id
   AND subsel.gj = sm.beleg_gj
   AND subsel.mandant_id  =sm.mandant_id
   AND subsel.statusmeldung_id = sm.statusmeldung_id

   JOIN dbp_msi_view_rpw.mv_ersteller_rpw_gruppe_zu_per_2 ergzp
   ON sm.ersteller_id = ergzp.rpw_ersteller_id
   AND sm.mandant_id = ergzp.mandant_id
   AND dat_beleg BETWEEN ergzp.dat_von AND ergzp.dat_bis

   WHERE sm.mandant_id = 1;
