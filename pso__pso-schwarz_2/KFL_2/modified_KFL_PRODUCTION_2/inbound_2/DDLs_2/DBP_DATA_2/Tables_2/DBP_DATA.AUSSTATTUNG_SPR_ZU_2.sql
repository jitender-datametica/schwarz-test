--==============================================================
-- Table: ausstattung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausstattung_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSSTATTUNG_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   ausstattung_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID des Ausstattungsmerkmals. Wird im DWH vergeben',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   ausstattung_bez                     VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Ausstattungsmerkmals, z.Bsp. Kundenkasse',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSSTATTUNG_SPR_ZU PRIMARY KEY (mandant_id, ausstattung_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - sprachabhängige Bezeichnung der Ausstattungsmerkmale, z.Bsp. Leergutkasse';

