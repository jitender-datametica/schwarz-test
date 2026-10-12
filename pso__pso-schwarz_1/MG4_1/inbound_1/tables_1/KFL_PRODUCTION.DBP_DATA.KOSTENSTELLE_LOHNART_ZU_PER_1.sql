create or replace TABLE KFL_PRODUCTION.DBP_DATA.KOSTENSTELLE_LOHNART_ZU_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KOSTENSTELLE_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus ZHR_00_DWH_PSU / KOSTL',
	LOHNART_ID VARCHAR(5) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'ID der Lohnart; Quelltabelle/feld: ZHR_00_DWH_PSU / LGART',
	ZEITART_ID VARCHAR(10) NOT NULL DEFAULT '-1' COMMENT 'ID der Zeitart, Quelltabelle/feld: ZHR_00_DWH_PSU / ZTART',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahresmonat, Format YYYYMM',
	KOSTENSTELLE_VON_ID VARCHAR(10) NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle Von - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PSU / KOSTVON',
	KOSTENSTELLE_NACH_ID VARCHAR(10) NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle Nach - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PSU / KOSTAN',
	ABRECHNUNG_FUER_PERIODE NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Fuerperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PSU / FPPER',
	ABRECHNUNGSTYP_FUER_PERIODE VARCHAR(5) NOT NULL DEFAULT '-1' COMMENT 'Abrechnungstyp; Quelltabelle/feld: ZHR_00_DWH_PSU / ABRTYP',
	ZAHLUNG_DAT DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum der Zahlung; Quelltabelle/feld: ZHR_00_DWH_PSU / BONDT',
	KRK_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Globale ID des Kostenrechnungskreises',
	WRG_ID VARCHAR(3) COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	ABRECHNUNG_IN_PERIODE NUMBER(38,0) DEFAULT -1 COMMENT 'Inperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PSU / INPER',
	ANZAHL_LOHNART NUMBER(18,2) NOT NULL DEFAULT 0 COMMENT 'Anzahl bezahlte Stunden_1 resp. Tage (abhängig von der Lohnart) nach Lohnarten (Überstundenzuschläge), Quelltabelle/feld: ZHR_00_DWH_PAY_V / ANZHL',
	BETRAG_LOHNART NUMBER(18,2) DEFAULT 0 COMMENT 'Lohnkosten in Landeswährung je Lohnart für Überstundenzuschläge, Quelltabelle/feld: ZHR_00_DWH_PSU / BETRAG',
	SYSTEM_ID NUMBER(38,0) COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KOSTENSTELLE_LOHNART_ZU_PER primary key (MANDANT_ID, KOSTENSTELLE_ID, LOHNART_ID, ZEITART_ID, KJMO, KOSTENSTELLE_VON_ID, KOSTENSTELLE_NACH_ID, ZAHLUNG_DAT, ABRECHNUNGSTYP_FUER_PERIODE, ABRECHNUNG_FUER_PERIODE)
)COMMENT='SHR - Tabelle enthaelt Daten zu Lohnarten und Zeitarten auf Kostenstellenebene - 1. Quelle in SAP HCM: ZHR_00_DWH_PSU - Direktanbindung über AbInitio;  2. Quelle manueller Sharepointupload'
;