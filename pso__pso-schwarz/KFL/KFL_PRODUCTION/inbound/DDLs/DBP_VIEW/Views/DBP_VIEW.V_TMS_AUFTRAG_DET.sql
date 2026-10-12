create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_AUFTRAG_DET(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_AUFTRAG_ID COMMENT 'ID des Auftrags (Auftragsnummer). Aus plps.au_nr',
	TMS_AUFTRAG_UNTER_ID COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plps.au_unter_nr',
	TMS_AUFTRAG_POS_ID COMMENT 'Laufende Nummer zur Identifizierung einer Auftragsposition innerhalb eines Auftrages. Aus plps.au_lfnr',
	TMS_AUFTRAG_DET_LFD_NR COMMENT 'SKey für die Tabelle tms_auftrag_det im Quellsystem. Aus plps.au_lfnr',
	ART_ID COMMENT 'Artikelnummer der Auftragsposition',
	ORIG_ART_NR COMMENT 'Artikelnummer der Auftragsposition inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.',
	MENGE_KOMMISSIONIERT COMMENT 'Fertig kommissionierte Menge',
	STATUS_FERTIG_CD COMMENT 'Fertig Kennzeichen: F = Kommissionierung abgeschlossen weil entweder ausreichende Menge kommissioniert wurde oder weil der Rest zur Fehlmenge erklärt wurde.',
	TMS_TRANSPORTMITTEL_ID COMMENT 'ID des Transportmittels.',
	ANZ_TRANSPORTMITTEL COMMENT 'Anzahl des Transportmittels.',
	WARENEINGANG_BELEG_ID COMMENT 'Belegnummer des Wareneingangs, auf T = EBELN.',
	DAT_WARENEINGANG COMMENT 'Datum des Wareneingangs',
	TMS_AUFTRAG_ORIG_ID COMMENT 'Originale Auftragsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.',
	TMS_AUFTRAG_ORIG_UNTER_ID COMMENT 'Originale Positionsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.'
) COMMENT='TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag auf Positionsebene.'
 as 
    SELECT 
        mandant_id,
        system_id,
        tms_auftrag_id,
        tms_auftrag_unter_id,
        tms_auftrag_pos_id,
        tms_auftrag_det_lfd_nr,
        art_id,
        orig_art_nr,
        menge_kommissioniert,
        status_fertig_cd,
        tms_transportmittel_id,
        anz_transportmittel,
        wareneingang_beleg_id,
        dat_wareneingang,
        tms_auftrag_orig_id,
        tms_auftrag_orig_unter_id

FROM DBP_DATA.TMS_AUFTRAG_DET ;
