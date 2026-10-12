--==============================================================
-- Table: disposition_rhythmus_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disposition_rhythmus_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISPOSITION_RHYTHMUS_SPR_ZU (
   disposition_rhythmus_id             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)',
   disposition_rhythmus_bez            VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung für den Dispositionsrhythmus (wie oft, an welchen Wochentagen).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISPOSITION_RHYTHMUS_SPR_ZU PRIMARY KEY (disposition_rhythmus_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP408 LVS -Sprachzuordnung  für lfrhy (Dispositionsrhythmus) aus SAP T439H';

