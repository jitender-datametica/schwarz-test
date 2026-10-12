create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_AUFTRAG_DET_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_AUFTRAG_ID VARCHAR(30) NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plps.au_nr',
	TMS_AUFTRAG_UNTER_ID NUMBER(38,0) NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plps.au_unter_nr',
	TMS_AUFTRAG_POS_ID VARCHAR(5) NOT NULL COMMENT 'Laufende Nummer zur Identifizierung einer Auftragsposition innerhalb eines Auftrages. Aus plps.au_lfnr',
	TMS_AUFTRAG_DET_LFD_NR NUMBER(38,0) NOT NULL COMMENT 'SKey für die Tabelle tms_auftrag_det_1 im Quellsystem. Aus plps.au_lfnr',
	ART_ID NUMBER(38,0) COMMENT 'Artikelnummer der Auftragsposition',
	ORIG_ART_NR VARCHAR(30) COMMENT 'Artikelnummer der Auftragsposition inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.',
	MENGE_KOMMISSIONIERT NUMBER(38,2) COMMENT 'Fertig kommissionierte Menge',
	STATUS_FERTIG_CD VARCHAR(3) COMMENT 'Fertig Kennzeichen: F = Kommissionierung abgeschlossen weil entweder ausreichende Menge kommissioniert wurde oder weil der Rest zur Fehlmenge erklärt wurde.',
	TMS_TRANSPORTMITTEL_ID NUMBER(38,0) COMMENT 'ID des Transportmittels.',
	ANZ_TRANSPORTMITTEL NUMBER(38,0) COMMENT 'Anzahl des Transportmittels.',
	WARENEINGANG_BELEG_ID VARCHAR(30) COMMENT 'Belegnummer des Wareneingangs, auf T = EBELN.',
	DAT_WARENEINGANG DATE COMMENT 'Datum des Wareneingangs',
	TMS_AUFTRAG_ORIG_ID VARCHAR(30) COMMENT 'Originale Auftragsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.',
	TMS_AUFTRAG_ORIG_UNTER_ID NUMBER(38,0) COMMENT 'Originale Positionsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_AUFTRAG_DET primary key (MANDANT_ID, SYSTEM_ID, TMS_AUFTRAG_ID, TMS_AUFTRAG_UNTER_ID, TMS_AUFTRAG_POS_ID)
)COMMENT='TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag auf Positionsebene.'
;
