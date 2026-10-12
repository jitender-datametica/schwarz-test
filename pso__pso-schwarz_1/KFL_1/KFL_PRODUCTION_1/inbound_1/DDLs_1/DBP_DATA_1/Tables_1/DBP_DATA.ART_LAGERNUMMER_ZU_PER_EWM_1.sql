--==============================================================
-- Table: art_lagernummer_zu_per_ewm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_lagernummer_zu_per_ewm_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:47:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_LAGERNUMMER_ZU_PER_EWM_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   art_guid_c22                        VARCHAR(22)     NOT NULL COMMENT 'Materialnummer CHAR 22',
   art_id                              NUMBER(38,0)    COMMENT 'Artikelnummer       ',
   scu_guid                            VARCHAR(32)     NOT NULL COMMENT 'GUID für Supply-Chain-Unit_1',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   verfuegungsberechtigter_guid        VARCHAR(32)     NOT NULL COMMENT 'Verfügungsberechtigter (GUID)',
   dat_von                             DATE            NOT NULL COMMENT 'YYYY-MM_1-DD // Aktion_1 gültig (von)',
   dat_bis                             DATE            COMMENT 'YYYY-MM_1-DD // Aktion_1 gültig (bis)',
   loesch_fg                           NUMBER(38,0)    COMMENT 'Löschvormerkung',
   einlager_steuerung_id               VARCHAR(4)      COMMENT 'Einlagerungssteuerung',
   lagerplatztyp_id                    VARCHAR(4)      COMMENT 'Lagerplatztyp',
   blocklagertyp_id                    VARCHAR(4)      COMMENT 'Blocklager',
   auslager_steuerung_id               VARCHAR(4)      COMMENT 'Lagerbereichskennzeichen',
   lagerbereichskennzeichen_id         VARCHAR(4)      COMMENT 'Auslagerungssteuerung',
   verpackungsklasse_id                VARCHAR(2)      COMMENT 'Kaufland Verpackungsklasse',
   anz_ladtraeger_max                  NUMBER(4,0)     COMMENT 'Kaufland-Spezifische Informationen max Ladungsträger',
   artikelsortiment_id                 VARCHAR(1)      COMMENT 'Kauflandspezifische Info Sortiments ID',
   referenzgewicht_id                  NUMBER(15,3)    COMMENT 'referenzgewicht_id',
   dat_we_check                        DATE            COMMENT 'Kaufland-specific information GR Check Date',
   anz_tage_bis_we_check               NUMBER(38,0)    COMMENT 'Kaufland-specific information GR Check Countdown',
   stellplatz_faktor                   NUMBER(5,2)     COMMENT 'Stellplatzfaktor',
   automation_kennz                    VARCHAR(1)      COMMENT 'Kennzeichen Automation',
   datzeit_aenderung                   NUMERIC(15)     COMMENT 'Zeitpunkt an dem das Objekt zuletzt geändert wurde',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Materialdaten pro Lagernummer';
