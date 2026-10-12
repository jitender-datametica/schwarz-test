--==============================================================
-- Table: handling_unit_ewm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: handling_unit_ewm_1
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:27:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HANDLING_UNIT_EWM_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   log_guid                            VARCHAR(32)          NOT NULL COMMENT 'Warenbewegungslog HU',
   handling_unit_guid                  VARCHAR(32)          NOT NULL COMMENT 'Handling Unit_1 GUID',
   quelle                              VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Quelltabelle SAP',
   parent_handling_unit_guid           VARCHAR(32)          COMMENT 'Handling Unit_1 GUID Parent',
   lageraufgabe_id                     INTEGER    COMMENT 'Lageraufgabe_1',
   handling_unit_id                    VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Handling Unit_1 ID',
   packmittel_guid                     VARCHAR(32)          COMMENT 'Packmittel GUID',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Lagernummer',
   lagereinheitentyp_id                VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Lagereinheitentyp',
   gewicht_brutto                      NUMBER(29,3)    COMMENT 'Bruttogewicht',
   gewicht_netto                       NUMBER(29,3)    COMMENT 'Nettogewicht',
   gewicht_einh_id                     VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Gewichtseinheit',
   eigengewicht                        NUMBER(29,3)    COMMENT 'Eigengewicht HU',
   eigengewicht_einh_id                VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Einheit Eigengewicht HU',
   volumen_brutto                      NUMBER(29,3)    COMMENT 'Bruttovolumen',
   volumen_netto                       NUMBER(29,3)    COMMENT 'Nettovolumen',
   volumen_einh_id                     VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Volumeneinheit',
   eigenvolumen                        NUMBER(29,3)    COMMENT 'Eigenvolumen HU',
   eigenvolumen_einh_id                VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Einheit Eigenvolumen HU',
   datzeit_lageraufgabe_bestaetigung   TIMESTAMP_LTZ   COMMENT 'Bestätigung Lageraufgabe_1 UTC-Zeitstempel in Langform (JJJJMMTThhmmss,mmmuuun)',
   anzahl_stellplaetze                 NUMBER(29,2)     COMMENT 'Anzahl Stellplätze',
   menge_gefahrgut                     NUMBER(29,2)     COMMENT 'Menge Gefahrgut',
   status_id_intern                    VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Internet Status_1 einer HU',
   top_hu_fg                           INTEGER    COMMENT 'Übergeordnete HU',
   bottom_hu_fg                        INTEGER    COMMENT 'Untergeordnete HU',
   konsolidierungsgruppe_id            VARCHAR(10)     COMMENT 'Konsolidierungsgruppe',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);
