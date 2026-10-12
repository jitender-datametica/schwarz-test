create or replace TABLE KFL_PRODUCTION.DBP_DATA.MA_KOSTENSTELLE_LOHNART_ZU_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KOSTENSTELLE_ID VARCHAR(10) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTL',
	MITARBEITER_ID VARCHAR(20) NOT NULL COMMENT 'Eindeutige anonymisierte ID des Mitarbeiters',
	LOHNART_ID VARCHAR(5) NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'ID der Lohnart; Quelltabelle/feld: ZHR_00_DWH_PSU / LGART',
	ZEITART_ID VARCHAR(10) NOT NULL DEFAULT '-1' COMMENT 'ID der Zeitart; Quelltabelle/feld: ZHR_00_DWH_PAY_V / ZTART ',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahresmonat, Format YYYYMM',
	KOSTENSTELLE_VON_ID VARCHAR(10) NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle Von - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTVON ',
	KOSTENSTELLE_NACH_ID VARCHAR(10) NOT NULL DEFAULT '-1' COMMENT 'Kostenstelle An - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTAN ',
	ABRECHNUNG_FUER_PERIODE NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Fuerperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / FPPER ',
	ABRECHNUNGSTYP_FUER_PERIODE VARCHAR(5) NOT NULL DEFAULT '-1' COMMENT 'Abrechnungstyp; Quelltabelle/feld: ZHR_00_DWH_PAY_V / ABRTYP ',
	ZAHLUNG_DAT DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum der Zahlung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / BONDT ',
	KRK_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Globale ID des Kostenrechnungskreises',
	ABRECHNUNG_IN_PERIODE NUMBER(38,0) DEFAULT -1 COMMENT 'Inperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / INPER ',
	ANZAHL_LOHNART NUMBER(18,2) NOT NULL DEFAULT 0 COMMENT 'Anzahl bezahlte Stunden_1 resp. Tage (abhängig von der Lohnart) nach Lohnarten (Überstundenzuschläge), Quelltabelle/feld: ZHR_00_DWH_PAY_V / ANZHL',
	SYSTEM_ID NUMBER(38,0) COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_MA_KOSTENSTELLE_LOHNART_ZU_PER primary key (MANDANT_ID, KOSTENSTELLE_ID, MITARBEITER_ID, LOHNART_ID, ZEITART_ID, KJMO, KOSTENSTELLE_VON_ID, KOSTENSTELLE_NACH_ID, ZAHLUNG_DAT, ABRECHNUNGSTYP_FUER_PERIODE, ABRECHNUNG_FUER_PERIODE)
)COMMENT='SHR - Tabelle enthaelt Daten zu Lohnarten und Zeitarten auf Mitarbeiter / Kostenstellenebene - 1. Quelle SAP HCM: ZHR_00_DWH_PAY_V. Direktanbindung über AbInitio; 2. Quelle manueller Sharepointupload'
;