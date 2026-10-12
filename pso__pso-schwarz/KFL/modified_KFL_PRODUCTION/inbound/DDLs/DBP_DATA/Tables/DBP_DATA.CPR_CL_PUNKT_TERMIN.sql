--==============================================================
-- Table: cpr_cl_punkt_termin
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_cl_punkt_termin
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CPR_CL_PUNKT_TERMIN (
   checkliste_punkt_id                 VARCHAR(32)      NOT NULL COMMENT 'Eindeutige ID eines Checklistenpunkts',
   cpr_suchfeld                        VARCHAR(40)      NOT NULL COMMENT 'Aus der Quelle geliefertes Suchfeld',
   suchfeld_bez                        VARCHAR(60)      COMMENT 'zusätzliche Bezeichnung',
   ok_fg                               INTEGER     COMMENT 'Kennzeichnung gültiger Termin. gleich 1, wenn ok',
   dat_ende_ist                        DATE             NOT NULL COMMENT 'tatsächliches Endedatum. Das Erreichen dieses Datums triggert die Speicherung des Datensatzes',
   cl_punkt_bez                        VARCHAR(40)      NOT NULL COMMENT 'Sprachabhängige Bezeichnung zur ID im Suchfeld des Checklistenpunkts',
   cl_punkt_langtext                   VARCHAR(320)     COMMENT 'Sprachabhängiger Langtext eines Checklistenpunkts',
   cpr_checkliste_id                   VARCHAR(32)      COMMENT 'unique ID der Checkliste',
   checkliste_nr                       VARCHAR(30)      NOT NULL COMMENT 'zusaetzliche ID pro Checkliste, entspricht cpr_ext_id_cl',
   cpr_checkliste_bez                  VARCHAR(40)      NOT NULL COMMENT 'Sprachabhängige Bezeichnung der Checkliste',
   cpr_checkliste_langtext             VARCHAR(320)     COMMENT 'Sprachabhängiger Langtext zur Checkliste',
   projekt_phase_id                    VARCHAR(32)      COMMENT 'unique ID der Phase',
   phasenart_id                        VARCHAR(20)      COMMENT 'Schlüssel der Phasenart, z.Bsp P7-Planung',
   teil_massn_fg                       INTEGER     COMMENT 'Dieses Flag kennzeichnet eine Teilmassnahme',
   teil_massnahme_id                   VARCHAR(30)      COMMENT 'eindeutige ID der Teilmassnahme',
   einzel_massnahme                    VARCHAR(30)      COMMENT 'Einelmassnahme',
   cpr_phase_bez                       VARCHAR(40)      NOT NULL COMMENT 'Sprachabhängige Beschreibung der Projektphase',
   cpr_phase_langtext                  VARCHAR(320)     COMMENT 'Sprachabhängiger Langtext zur Projektphase',
   projekt_id                          VARCHAR(32)      NOT NULL COMMENT 'Eindeutige ID des Projekts',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. Deutschland ist Mandant 1',
   land_id                             VARCHAR(2)       NOT NULL COMMENT 'Land, auf das sich das Projekt bezieht',
   techn_platz_id                      VARCHAR(30)      COMMENT 'Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit',
   projekt_nr                          VARCHAR(30)      NOT NULL COMMENT 'eindeutige Projektnummer pro Projekt und Sprache',
   massnahme_id                        VARCHAR(20)      COMMENT 'Kennzeichnung einer Massnahme, z.Bsp. KB',
   wup_id                              INTEGER     COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   cpr_standort                        VARCHAR(40)      COMMENT 'Kann den Namen eines Standortes enthalten, z.Bsp. Heilbronn',
   cpr_filialtyp_bez                   VARCHAR(30)      COMMENT 'Bezeichnung, z.Bsp. HH, KL',
   investor_eigenobj                   VARCHAR(10)      COMMENT 'Angabe zum Eigentumsverhältnis, z.Bsp. Miete',
   cpr_general_planer                  VARCHAR(40)      COMMENT 'Generalplaner Name',
   cpr_objekt_steurer                  VARCHAR(40)      COMMENT 'Objektsteuerer Name',
   cpr_projekt_bez                     VARCHAR(40)      NOT NULL COMMENT 'Sprachabhängige Projektbeschreibung',
   cpr_projekt_langtext                VARCHAR(320)     COMMENT 'Sprachabhängiger Langtext zum Projekt',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
   dat_extrakt                         DATE             NOT NULL COMMENT 'Erstellungsdatum des Satzes',
   cpr_phase_version_id                VARCHAR(10)      COMMENT 'Version (Kundenfeld) einer Phase aus zz_ppo_version. Inhalt z.Bsp. 1.1',
   cpr_phase_version_dat               DATE             COMMENT 'Datum_ab einer Version aus zz_ppo_datum_vom',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CPR_CL_PUNKT_TERMIN PRIMARY KEY (checkliste_punkt_id, cpr_suchfeld) NOT ENFORCED
)  COMMENT = 'IOS - Archivtabelle fuer die abgeschlossenen Projekte mit den Endterminen. Denormalisiert';

