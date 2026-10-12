--==============================================================
-- Table: ssm_cluster_prozess_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_cluster_prozess_zu_2
   generated from Powerdesigner on Montag, 30. Januar 2023 15:42:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_cluster_prozess_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ssm_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines '),
ssm_prozess_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Prozesses'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
etagen_anz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gibt die Anzahl der Etagen in einer FIliale an. Je nach Etagenanzahl können sich die Sollwerte in den Prozessen unterscheiden.'),
wup_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell'),
wup_abt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Abteilung innerhalb eines Marktes'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
fixwert_mo NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess für Montag'),
fixwert_di NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess dienstäglich für Dienstag'),
fixwert_mi NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess für Mittwoch'),
fixwert_do NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess für Donnerstag'),
fixwert_fr NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess für Freitag'),
fixwert_sa NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess für Samstag'),
fixwert_so NUMERIC(9,2) DEFAULT 0 NOT NULL
OPTIONS(description='Fixwert (in Industrieminuten) für den Prozess für Sonntag'),
zeit_benchmark BIGNUMERIC(18,16) DEFAULT 0 NOT NULL
OPTIONS(description='Prozesszeit (gemessen) für die Verrechnung von dynamischen Prozessen (Treiber * Prozesszeit)'),
prognose_multiplikator NUMERIC(9,6) DEFAULT 0 NOT NULL OPTIONS(description='Multiplikator für Korrekturen (Prognose)'),
anpassung_nettoleistung_up_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag, ob die Nettoleistung (Measure) am Prozess auf Plan erhöht werden darf'),
anpassung_nettoleistung_down_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag, ob die Nettoleistung (Measure) am Prozess auf Plan erhöht werden darf'),
start_variabel_typ STRING(1)
OPTIONS(description='Startzeitpunkt. Variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. O=Öffnung/S=Schliessung'),
start_variabel_wert NUMERIC(9,2)
OPTIONS(description='Wert für variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. -1 für 1 h vor der Standardöffnung'),
ende_variabel_typ STRING(1)
OPTIONS(description='Endzeitpunkt. Variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. O=Öffnung/S=Schliessung'),
ende_variabel_wert NUMERIC(9,2)
OPTIONS(description='Wert für variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. 1 für 1 h nach der Standardöffnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ssm_cluster_id, ssm_prozess_id, dat_von, etagen_anz) NOT ENFORCED
)
OPTIONS(description='VIS - Sollstundenmodell - Mappingtabelle der Prozesse zu den landesindividuellen Abteilungsclustern mit den entsprechenden Zeitwerten');