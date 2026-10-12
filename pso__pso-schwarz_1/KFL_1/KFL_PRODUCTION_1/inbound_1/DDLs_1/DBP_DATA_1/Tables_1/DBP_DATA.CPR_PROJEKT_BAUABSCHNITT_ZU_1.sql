--==============================================================
-- Table: cpr_projekt_bauabschnitt_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_projekt_bauabschnitt_zu_1
   generated from Powerdesigner on Dienstag, 27. Juni 2023 17:37:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_PROJEKT_BAUABSCHNITT_ZU_1 (
   projekt_unter_id                    VARCHAR(32)      NOT NULL COMMENT 'eindeutige ID aus Aufgabe oder Checkliste_Punkt',
   projekt_id                          VARCHAR(32)      NOT NULL COMMENT 'Eindeutige ID des Projekts',
   bauabschnitt_id                     VARCHAR(32)      COMMENT 'eindeutige ID der Bauabschnitte aus Aufgabe oder Phase, bzw. Kopf aus Projekt',
   cpr_ext_id                          VARCHAR(30)      NOT NULL DEFAULT ' ' COMMENT 'eindeutige Projektnummer pro Projekt und Sprache',
   cpr_systemstatus1_prj_id            NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Schluessel für den Projekt-Systemstatus1, Enthält numerische Werte von 1 aufsteigend',
   cpr_systemstatus1_bauab_id          NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Schluessel für den Bauabschnitt-Systemstatus1, Enthält numerische Werte von 1 aufsteigend',
   dat_eroeffnung_projekt              DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'maximaler Eröffnungstermin pro Projekt',
   sort_id                             NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Quelle von bauabschnitt_id, 1 = cpr_projekt_per_1, 2 = cpr_phase_per_1 oder cpr_aufgabe_per_1',
   cpr_suchfeld_id                     NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
   dat_start_ist                       DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Isttermin Start',
   dat_ende_ist                        DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Isttermin Ende',
   dat_start_vorhersage                DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Prognosetermin Start',
   dat_ende_vorhersage                 DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Prognosetermin Ende',
   dat_start_einschraenkung            DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Solltermin Start',
   dat_ende_einschraenkung             DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Solltermin Ende',
   projekt_existiert_vor_14tage_fg     NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag: War das Projekt vor 14 Tagen (actual date - 14) existent (1 = existent)',
   dat_start_ist_minus_14              DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Isttermin Start - Stand vor 14 Tagen',
   dat_ende_ist_minus_14               DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Isttermin Ende - Stand vor 14 Tagen',
   dat_start_vorhersage_minus_14       DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Prognosetermin Start - Stand vor 14 Tagen',
   dat_ende_vorhersage_minus_14        DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Prognosetermin Ende - Stand vor 14 Tagen',
   dat_start_einschraenkung_minus_14   DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Solltermin Start - Stand vor 14 Tagen',
   dat_ende_einschraenkung_minus_14    DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Solltermin Ende  - Stand vor 14 Tagen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_PROJEKT_BAUABSCHNITT_ZU PRIMARY KEY (projekt_unter_id) NOT ENFORCED
)  COMMENT = 'IOS - Tabelle für die korrekte Zuordnung von Terminen zu Bauabschnitten und Projekten';