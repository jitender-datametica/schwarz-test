create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_AUFTRAG_VERPACKUNG(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_VERPACKUNG_ID COMMENT 'ID der Verpackung',
	TMS_VERPACKUNG_LFD_NR COMMENT 'Identifier der Verpackung im Quellsystem',
	TMS_AUFTRAG_ID COMMENT 'ID des Auftrags (Auftragsnummer). Aus plau.au_nr',
	TMS_AUFTRAG_UNTER_ID COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr',
	TMS_TRANSPORTMITTEL_ID COMMENT 'ID des Transportmittels auf dem die Verpackung verpackt wird.',
	ANZ_VERPACKUNG COMMENT 'Anzahl gleichartiger Verpackungen',
	TMS_VERPACKUNG_BEM_TXT COMMENT 'Freitext für Bemerkungen zur Verpackung.'
) COMMENT='TMS - Die Tabelle enthält Verpackunsinformationen zum Auftrag inklusive des genutzen Transportmittels der Verpackung.'
 as 
    SELECT 
        mandant_id,
        system_id,
        tms_verpackung_id,
        tms_verpackung_lfd_nr,
        tms_auftrag_id,
        tms_auftrag_unter_id,
        tms_transportmittel_id,
        anz_verpackung,
        tms_verpackung_bem_txt

FROM DBP_DATA.TMS_AUFTRAG_VERPACKUNG ;
