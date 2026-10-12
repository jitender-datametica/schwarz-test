--==============================================================
-- Table: in_instandhaltung_objekt_qual
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_instandhaltung_objekt_qual
   generated from Powerdesigner on Montag, 11. April 2022 11:44:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_INSTANDHALTUNG_OBJEKT_QUAL (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   qual_meldung_id                     INTEGER    NOT NULL COMMENT 'ID der Qualitaetsmeldung aus qmnum',
   tp_objekt_id                        INTEGER    COMMENT 'Auspraegung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP',
   auftrag_id                          VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   techn_platz_id                      VARCHAR(30)     COLLATE 'en-ci' COMMENT 'Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit',
   dat_stoer_beginn                    DATE            COMMENT 'Stoerungsbeginn (Datum)',
   cs_auftrag_prio                     INTEGER    COMMENT 'Für die Auftragsart 4IHA ist bei PRIOK eine Priorität von 1, 2 oder 3 angegeben. Falls keine Priorität angegeben: Null. (cs = customer service)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   UNIQUE (mandant_id, qual_meldung_id),
   CONSTRAINT PK_IN_INSTANDHALTUNG_OBJEKT_QUAL PRIMARY KEY (qual_meldung_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS - IND View VIQMEL, enthaelt Tabellen QMEL (Qualitaetsmeldung) und ILOA (Standort und Kontierung zum ICH-Objekt)';