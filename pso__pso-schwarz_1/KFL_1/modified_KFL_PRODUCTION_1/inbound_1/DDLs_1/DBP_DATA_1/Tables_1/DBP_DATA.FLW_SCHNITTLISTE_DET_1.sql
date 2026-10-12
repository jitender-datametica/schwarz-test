--==============================================================
-- Table: flw_schnittliste_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnittliste_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITTLISTE_DET_1 (
   schnittliste_id                     INTEGER     NOT NULL COMMENT 'ID der Schnittliste aus ctlnr',
   schnitt_id                          INTEGER     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         INTEGER     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   schnitt_verwendung_prozent          NUMBER(29,2)      NOT NULL COMMENT 'Proenzsatz der Schnitt-Verwendung aus cutpr',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   menge                               NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITTLISTE_DET PRIMARY KEY (schnittliste_id, schnitt_id, sek_schl_typ_id, sek_schl_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnittlistenpositionen aus ctlp';

