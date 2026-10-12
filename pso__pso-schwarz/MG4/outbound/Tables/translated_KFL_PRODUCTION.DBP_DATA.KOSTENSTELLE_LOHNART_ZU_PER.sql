CREATE OR REPLACE TABLE kfl_production_dbp_data.kostenstelle_lohnart_zu_per (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle aus ZHR_00_DWH_PSU / KOSTL'),
lohnart_id STRING(5) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='ID der Lohnart; Quelltabelle/feld: ZHR_00_DWH_PSU / LGART'),
zeitart_id STRING(10) DEFAULT '-1' NOT NULL
OPTIONS(description='ID der Zeitart, Quelltabelle/feld: ZHR_00_DWH_PSU / ZTART'),
kjmo INTEGER NOT NULL OPTIONS(description='Kalenderjahresmonat, Format YYYYMM'),
kostenstelle_von_id STRING(10) DEFAULT '-1' NOT NULL
OPTIONS(description='Kostenstelle Von - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PSU / KOSTVON'),
kostenstelle_nach_id STRING(10) DEFAULT '-1' NOT NULL
OPTIONS(description='Kostenstelle Nach - wird benötigt, wenn ein Mitarbeiter einer Filiale an eine andere Filiale ausgeliehen wird; Quelltabelle/feld: ZHR_00_DWH_PSU / KOSTAN'),
abrechnung_fuer_periode INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Fuerperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PSU / FPPER'),
abrechnungstyp_fuer_periode STRING(5) DEFAULT '-1' NOT NULL
OPTIONS(description='Abrechnungstyp; Quelltabelle/feld: ZHR_00_DWH_PSU / ABRTYP'),
zahlung_dat DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Datum der Zahlung; Quelltabelle/feld: ZHR_00_DWH_PSU / BONDT'),
krk_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Globale ID des Kostenrechnungskreises'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
abrechnung_in_periode INTEGER DEFAULT - 1
OPTIONS(description='Inperiode Abrechnung; Quelltabelle/feld: ZHR_00_DWH_PSU / INPER'),
anzahl_lohnart NUMERIC(18,2) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl bezahlte Stunden resp. Tage (abhängig von der Lohnart) nach Lohnarten (Überstundenzuschläge), Quelltabelle/feld: ZHR_00_DWH_PAY_V / ANZHL'),
betrag_lohnart NUMERIC(18,2) DEFAULT 0
OPTIONS(description='Lohnkosten in Landeswährung je Lohnart für Überstundenzuschläge, Quelltabelle/feld: ZHR_00_DWH_PSU / BETRAG'),
system_id INTEGER OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zeitart_id, kjmo, kostenstelle_von_id, kostenstelle_nach_id, zahlung_dat,
 abrechnungstyp_fuer_periode, abrechnung_fuer_periode) NOT ENFORCED
)
OPTIONS(description='SHR - Tabelle enthaelt Daten zu Lohnarten und Zeitarten auf Kostenstellenebene - 1. Quelle in SAP HCM: ZHR_00_DWH_PSU - Direktanbindung über AbInitio;  2. Quelle manueller Sharepointupload');