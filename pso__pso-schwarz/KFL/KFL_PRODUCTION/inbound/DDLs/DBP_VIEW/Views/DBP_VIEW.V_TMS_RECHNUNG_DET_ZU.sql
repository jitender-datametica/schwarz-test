create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_RECHNUNG_DET_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_RECH_BELEG_ID COMMENT 'ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr',
	TMS_RECH_BELEG_POS_ID COMMENT 'Rechnungspositionsnummer. Aus plrpos.beleg_posnr',
	TMS_RECH_BEZUG_LFD_NR COMMENT 'ID der Zuordnung / Referenz im Quellsystem.',
	BEZUGSART_ID COMMENT 'ID der Art des Belegbezugs: 0 = undefiniert; 1 = Tour; 2 = Tourposition; 3 = Auftrag; 4 = Auftragsposition; 5 = HAU / Gesamtauftrag; 6 = Tag; 7 = E_Bordero; 8 = Teil transport; 9 = Gesamtrechnung; 10 = Teil Transport E Bordero; 100 = TRM',
	BEZUG_SCHLUESSEL_NR COMMENT 'Gesamter Schluessel des Bezugsbelegs.',
	TMS_REF_NR COMMENT 'Erster Teil des Bezugsbelegs, bspw. Auftrag',
	TMS_REF_UNTER_NR COMMENT 'Zweiter Teil des Bezugsbelegs, bspw. Unterauftrag',
	TMS_REF_POS_NR COMMENT 'Dritter Teil des Bezugsbelegs, bspw. Auftragsposition'
) COMMENT='TMS - Zuordnungstabelle zwischen den Rechnungspositionen und je nach Bezugsart anderen Belegen wie bspw. Auftragspositionen, Tourenpositionen, Gesamtrechnungen, etc.'
 as 
    SELECT 
        mandant_id,
        system_id,
        tms_rech_beleg_id,
        tms_rech_beleg_pos_id,
        tms_rech_bezug_lfd_nr,
        bezugsart_id,
        bezug_schluessel_nr,
        tms_ref_nr,
        tms_ref_unter_nr,
        tms_ref_pos_nr

FROM DBP_DATA.TMS_RECHNUNG_DET_ZU ;
