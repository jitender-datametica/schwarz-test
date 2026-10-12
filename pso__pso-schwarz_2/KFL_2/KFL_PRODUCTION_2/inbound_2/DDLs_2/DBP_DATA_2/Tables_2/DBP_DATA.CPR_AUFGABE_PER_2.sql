--==============================================================
-- Table: cpr_aufgabe_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_aufgabe_per_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_AUFGABE_PER_2 (
   cpr_aufgabe_id                      VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID der Aufgabe aus xlctask',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   projekt_phase_id                    VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projektphase aus xlcphase',
   cpr_suchfeld_id                     NUMBER(38,0)     NOT NULL COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
   aufgabenart_id                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Aufgabenart. In der Regel werden nur 2 Byte benutzt',
   sortier_nummer                      NUMBER(38,0)     NOT NULL COMMENT 'interne Sortiernummer aus der Schnittstelle aus cpr_sort_nr',
   dat_start_ist                       DATE             COMMENT 'tatsächliches Startdatum aus actualstartdate',
   dat_ende_ist                        DATE             COMMENT 'tatsächliches Endedatum aus actualfinishdate',
   dat_start_plan                      DATE             COMMENT 'geplantes Startdatum aus planstartdate',
   dat_ende_plan                       DATE             COMMENT 'geplantes Endedatum aus planfinishdate',
   dat_start_max                       DATE             COMMENT 'Spätest_2 mögliches Startdatum aus lateststartdate',
   dat_ende_max                        DATE             COMMENT 'Spätest_2 mögliches Endedatum aus latest_finishdate',
   cpr_systemstatus1_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend. Aus xlcstat1',
   cpr_systemstatus2_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend aus xlcstat2',
   cpr_systemstatus3_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend aus xlcstat3',
   cpr_duunit                          VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Einheit der Dauer (Tage,Stunden_2,..) aus cpr_duunit',
   dauer                               NUMBER(18,3)     COMMENT 'Dauer in Einheit cpr_duunit aus cpr_durati',
   dat_start_einschraenkung            DATE             COMMENT 'Einschränkungsdatum aus cpr_constr',
   dat_ende_einschraenkung             DATE             COMMENT 'weiteres Einschränkungsdatum aus cpr_confin',
   cpr_prio                            NUMBER(38,0)     COMMENT 'Angabe zur Priorität aus cpr_prio',
   gesamt_puffer                       NUMBER(18,3)     COMMENT 'Gesamtpuffer in ??? aus cpr_buffer',
   dat_start_vorhersage                DATE             COMMENT 'Prognostizierter Starttermin aus forecast_start',
   dat_ende_vorhersage                 DATE             COMMENT 'Prognostizierter Endetermin aus forecast_ende',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_AUFGABE_PER PRIMARY KEY (cpr_aufgabe_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Aufgaben aus dem System cProjects aus der Quelle ctask';

