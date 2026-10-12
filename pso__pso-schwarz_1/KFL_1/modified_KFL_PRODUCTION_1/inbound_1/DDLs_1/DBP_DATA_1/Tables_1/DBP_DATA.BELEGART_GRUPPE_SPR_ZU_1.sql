--==============================================================
-- Table: belegart_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegart_gruppe_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEGART_GRUPPE_SPR_ZU_1 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   belegart_gruppe_id                  INTEGER     NOT NULL COMMENT 'Gruppierung über die Belegarten (fortlaufende Nummer)',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   belegart_gruppe_bez                 VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Belegartengruppen (z.Bsp. Rechnungsbeleg, Gutschrift,...)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEGART_GRUPPE_SPR_ZU PRIMARY KEY (system_id, mandant_id, belegart_gruppe_id) NOT ENFORCED
)  COMMENT = 'RPW - DATA - Sprachtabhängige Bezeichnungen für die Gruppierung der Belegart
             ';

