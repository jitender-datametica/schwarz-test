--==============================================================
-- Table: flw_schnittliste_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnittliste_det_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITTLISTE_DET_2 (
   schnittliste_id                     NUMBER(18,0)     NOT NULL COMMENT 'ID der Schnittliste aus ctlnr',
   schnitt_id                          NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   schnitt_verwendung_prozent          NUMBER(9,2)      NOT NULL COMMENT 'Proenzsatz der Schnitt-Verwendung aus cutpr',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   system_id                           NUMBER(38,0)     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   menge                               NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Menge',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITTLISTE_DET PRIMARY KEY (schnittliste_id, schnitt_id, sek_schl_typ_id, sek_schl_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnittlistenpositionen aus ctlp';

