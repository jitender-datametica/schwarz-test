--==============================================================
-- Table: ma_kostenstelle_lohnart_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ma_kostenstelle_lohnart_zu_per_1
   generated from Powerdesigner on Mittwoch, 22. März 2023 15:54:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_kostenstelle_lohnart_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle aus Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTL'),
mitarbeiter_id STRING(20) NOT NULL OPTIONS(description='Eindeutige anonymisierte ID des Mitarbeiters'),
lohnart_id STRING(5) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='ID der Lohnart; Quelltabelle/feld: ZHR_00_DWH_PSU / LGART'),
zeitart_id STRING(10) DEFAULT '-1' NOT NULL
OPTIONS(description='ID der Zeitart; Quelltabelle/feld: ZHR_00_DWH_PAY_V / ZTART '),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat, Format YYYYMM'),
kostenstelle_von_id STRING(10) DEFAULT '-1' NOT NULL
OPTIONS(description='Kostenstelle Von - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTVON '),
kostenstelle_nach_id STRING(10) DEFAULT '-1' NOT NULL
OPTIONS(description='Kostenstelle An - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine_1 andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PAY_V / KOSTAN '),
abrechnung_fuer_periode BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Fuerperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / FPPER '),
abrechnungstyp_fuer_periode STRING(5) DEFAULT '-1' NOT NULL
OPTIONS(description='Abrechnungstyp; Quelltabelle/feld: ZHR_00_DWH_PAY_V / ABRTYP '),
zahlung_dat DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum der Zahlung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / BONDT '),
krk_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Globale ID des Kostenrechnungskreises'),
abrechnung_in_periode BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Inperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PAY_V / INPER '),
anzahl_lohnart NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl bezahlte Stunden_1 resp. Tage (abhängig von der Lohnart) nach Lohnarten (Überstundenzuschläge), Quelltabelle/feld: ZHR_00_DWH_PAY_V / ANZHL'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mitarbeiter_id, zeitart_id, kjmo, kostenstelle_von_id, kostenstelle_nach_id, zahlung_dat,
 abrechnungstyp_fuer_periode, abrechnung_fuer_periode) NOT ENFORCED
)
OPTIONS(description='SHR - Tabelle enthaelt Daten zu Lohnarten und Zeitarten auf Mitarbeiter / Kostenstellenebene - 1. Quelle SAP HCM: ZHR_00_DWH_PAY_V. Direktanbindung über AbInitio; 2. Quelle manueller Sharepointupload');