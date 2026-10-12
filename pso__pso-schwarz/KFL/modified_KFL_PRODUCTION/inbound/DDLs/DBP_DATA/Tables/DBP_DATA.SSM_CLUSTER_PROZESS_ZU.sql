--==============================================================
-- Table: ssm_cluster_prozess_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_cluster_prozess_zu
   generated from Powerdesigner on Montag, 30. Januar 2023 15:42:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SSM_CLUSTER_PROZESS_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   ssm_cluster_id                      INTEGER     NOT NULL COMMENT 'ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines ',
   ssm_prozess_id                      INTEGER     NOT NULL COMMENT 'ID des Prozesses',
   dat_von                             DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   etagen_anz                          INTEGER     NOT NULL COMMENT 'Gibt die Anzahl der Etagen in einer FIliale an. Je nach Etagenanzahl können sich die Sollwerte in den Prozessen unterscheiden.',
   wup_bereich_id                      INTEGER     NOT NULL COMMENT 'ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell',
   wup_abt_id                          INTEGER     NOT NULL COMMENT 'ID der Abteilung innerhalb eines Marktes',
   dat_bis                             DATE             NOT NULL DEFAULT CAST ('9999-12-31' AS DATE) COMMENT 'Datum im Format JJJJ-MM-TT',
   fixwert_mo                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess für Montag',
   fixwert_di                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess dienstäglich für Dienstag',
   fixwert_mi                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess für Mittwoch',
   fixwert_do                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess für Donnerstag',
   fixwert_fr                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess für Freitag',
   fixwert_sa                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess für Samstag',
   fixwert_so                          NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Fixwert (in Industrieminuten) für den Prozess für Sonntag',
   zeit_benchmark                      NUMBER(38,16)    NOT NULL DEFAULT 0 COMMENT 'Prozesszeit (gemessen) für die Verrechnung von dynamischen Prozessen (Treiber * Prozesszeit)',
   prognose_multiplikator              NUMBER(29,6)      NOT NULL DEFAULT 0 COMMENT 'Multiplikator für Korrekturen (Prognose)',
   anpassung_nettoleistung_up_fg       INTEGER     NOT NULL COMMENT 'Flag, ob die Nettoleistung (Measure) am Prozess auf Plan erhöht werden darf',
   anpassung_nettoleistung_down_fg     INTEGER     NOT NULL COMMENT 'Flag, ob die Nettoleistung (Measure) am Prozess auf Plan erhöht werden darf',
   start_variabel_typ                  VARCHAR(1)       COMMENT 'Startzeitpunkt. Variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. O=Öffnung/S=Schliessung',
   start_variabel_wert                 NUMBER(29,2)      COMMENT 'Wert für variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. -1 für 1 h vor der Standardöffnung',
   ende_variabel_typ                   VARCHAR(1)       COMMENT 'Endzeitpunkt. Variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. O=Öffnung/S=Schliessung',
   ende_variabel_wert                  NUMBER(29,2)      COMMENT 'Wert für variable Steuerung der Prozesse(Tätigkeiten wie Verräumung) abhängig vom Standardöffnungszeiten. 1 für 1 h nach der Standardöffnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SSM_CLUSTER_PROZESS_ZU PRIMARY KEY (mandant_id, ssm_cluster_id, ssm_prozess_id, dat_von, etagen_anz) NOT ENFORCED
)  COMMENT = 'VIS - Sollstundenmodell - Mappingtabelle der Prozesse zu den landesindividuellen Abteilungsclustern mit den entsprechenden Zeitwerten';
