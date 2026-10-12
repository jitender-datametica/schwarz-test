--==============================================================
-- Table: cpr_cl_punkt_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_cl_punkt_per_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_CL_PUNKT_PER_1 (
   checkliste_punkt_id                 VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eines Checklistenpunkts',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
   cpr_checkliste_id                   VARCHAR(32)      COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projekt-Checkliste aus xlccheckl',
   cpr_apprel                          NUMBER(38,0)     COMMENT '???',
   aenderbar_kz                        VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichnet die Änderbarkeit des Checklistenpunkts',
   cl_punkt_gruppe_id                  VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Gruppierungsmerkmal',
   nicht_ok_fg                         NUMBER(38,0)     NOT NULL COMMENT 'Gleich 1, wenn nicht ok',
   nicht_relevant_fg                   NUMBER(38,0)     NOT NULL COMMENT 'gleich 1, wenn nicht relevant',
   obligatorisch_fg                    NUMBER(38,0)     NOT NULL COMMENT 'gleich 1, wenn obligatorisch',
   ok_fg                               NUMBER(38,0)     NOT NULL COMMENT 'gleich 1, wenn ok',
   sortier_nummer                      NUMBER(38,0)     COMMENT 'interne Sortiernummer aus der Schnittstelle',
   dat_start_ist                       DATE             COMMENT 'tatsächliches Startdatum',
   dat_ende_ist                        DATE             COMMENT 'tatsächliches Endedatum',
   dat_start_max                       DATE             COMMENT 'spätest_1 mögliches Startdatum',
   dat_ende_max                        DATE             COMMENT 'spätest_1 mögliches Endedatum',
   dat_start_plan                      DATE             COMMENT 'geplantes Startdatum',
   dat_ende_plan                       DATE             COMMENT 'geplantes Endedatum',
   term_einschr_typ                    VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Art_1 der terminlichen Einschränkung',
   dat_start_einschraenkung            DATE             COMMENT 'Einschränkungsdatum',
   termin_einschraenk_kz               VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Kennzeichen der terminlichen Einschränkung, z.Bsp. 7',
   dat_ende_einschraenkung             DATE             COMMENT 'weiteres Einschränkungsdatum',
   gesamt_puffer                       NUMBER(18,3)     COMMENT 'Gesamtpuffer in ???',
   cpr_prio                            NUMBER(38,0)     COMMENT 'Angabe zur Priorität',
   cpr_systemstatus1_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus1, Enthält numerische Werte von 1 aufsteigend',
   cpr_systemstatus3_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus3.  Enthält numerische Werte von 1 aufsteigend',
   cpr_systemstatus2_id                NUMBER(38,0)     NOT NULL COMMENT 'Schluessel für den Systemstatus2.  Enthält numerische Werte von 1 aufsteigend',
   cpr_suchfeld_id                     NUMBER(38,0)     COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
   dat_erstellung                      DATE             NOT NULL COMMENT 'Anlagedatum',
   sortier_nr_mhrwrtgkt                NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'Rangfolge bei mehreren gleichwertigen CL-Punkten. Wird im Versorgungsprozess ermittelt.',
   dat_start_vorhersage                DATE             COMMENT 'Prognostizierter Starttermin aus forecast_start',
   dat_ende_vorhersage                 DATE             COMMENT 'Prognostizierter Endetermin aus forecast_ende',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_CL_PUNKT_PER PRIMARY KEY (checkliste_punkt_id, dat_von) NOT ENFORCED
)  COMMENT = 'IOS - Items und Termine zu den Checklisten';

