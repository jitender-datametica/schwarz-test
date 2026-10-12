CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_KMR_PRUEFUNG_1
(
	MANDANT_ID,	
	AMX_SYSTEM_ID,
	PRUEFUNG_ID,
	PRUEFUNG_NR,
	PRUEFUNG_BEZ,
	PRUEFUNG_KLASSE_ID,
	PRUEFUNG_TYP_ID,
	PRUEFUNG_STATUS_ID,
	STANDORT_ID,
	GEPR_OE_ID,
	LEIT_ABTEILUNG_ID,
	DAT_PRUEF_ZEITRAUM_VON,
	DAT_PRUEF_ZEITRAUM_BIS,
	DAT_TERMIN_VEREINBART,
	DAT_VERSAND_ANKUENDIGUNG,
	DAT_BEGINN_PRUEFUNG,
	DAT_ENDE_PRUEFUNG,
	DAT_VERSAND_BERICHTSENTWURF,
	DAT_RUECKMELDUNG_BERICHTSENTWURF,
	DAT_VERSAND_BERICHT,
	DAT_VERSAND_BERICHT_KORRIGIERT,
	TAGESZEIT_ID,
	PRUEFFELD_ID,
	ERGEBNIS,
	ERGEBNIS_BERECHNET,
	ERGEBNIS_MANUELL,
	GEPR_PROZESS_ID,
	SEC_KZ,
        PRUEFUNG_BEREICH_ID
) AS
-- 20220518 twie: SPEC0153699 neue audimex Tabelle mit Prüfungen, inhaltlich getrenntes Datenmodell zu bestehenden Tabellen mit Präfix amx_ (diese nur für Kurzchecks)
-- 20220804 twie: SPEC0153699 mandant_id und sec_kz ergänzt für Securityfilter
-- 20221012 twie: SPEC0167837 sek_kz von 31 auf 4 
-- 202409 SPEC0242924 new attribute

SELECT 
         v01.mandant_id
        ,v01.amx_system_id
        ,v01.pruefung_id
        ,v01.pruefung_nr
        ,v01.pruefung_bez
        ,v01.pruefung_klasse_id
        ,v01.pruefung_typ_id
        ,v01.pruefung_status_id
        ,v01.standort_id
        ,v01.gepr_oe_id
        ,v01.leit_abteilung_id
        ,v01.dat_pruef_zeitraum_von
        ,v01.dat_pruef_zeitraum_bis
        ,v01.dat_termin_vereinbart
        ,v01.dat_versand_ankuendigung
        ,v01.dat_beginn_pruefung
        ,v01.dat_ende_pruefung
        ,v01.dat_versand_berichtsentwurf
        ,v01.dat_rueckmeldung_berichtsentwurf
        ,v01.dat_versand_bericht
        ,v01.dat_versand_bericht_korrigiert
        ,v01.tageszeit_id
        ,v01.prueffeld_id
        ,v01.ergebnis
        ,v01.ergebnis_berechnet
        ,v01.ergebnis_manuell
        ,v01.gepr_prozess_id
        ,4 ::BYTEINT AS sec_kz
        ,v01.PRUEFUNG_BEREICH_ID

FROM dbp_view.v_kmr_pruefung_1 v01;