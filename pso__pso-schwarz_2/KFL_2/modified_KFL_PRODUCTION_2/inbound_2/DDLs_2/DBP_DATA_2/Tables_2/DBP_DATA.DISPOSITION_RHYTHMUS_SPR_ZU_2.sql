--==============================================================
-- Table: disposition_rhythmus_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disposition_rhythmus_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISPOSITION_RHYTHMUS_SPR_ZU_2 (
   disposition_rhythmus_id             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)',
   disposition_rhythmus_bez            VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung für den Dispositionsrhythmus (wie oft, an welchen Wochentagen).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISPOSITION_RHYTHMUS_SPR_ZU PRIMARY KEY (disposition_rhythmus_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP408 LVS -Sprachzuordnung  für lfrhy (Dispositionsrhythmus) aus SAP T439H';

