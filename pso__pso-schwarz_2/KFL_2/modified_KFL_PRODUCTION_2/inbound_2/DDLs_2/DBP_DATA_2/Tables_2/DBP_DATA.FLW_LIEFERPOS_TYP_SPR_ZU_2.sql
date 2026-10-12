--==============================================================
-- Table: flw_lieferpos_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lieferpos_typ_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LIEFERPOS_TYP_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   lief_pos_typ_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Positionstyp Vertriebsbeleg z.Bsp. kostenlose Lieferung aus pstyv',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   lief_pos_typ_bez                    VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Lieferpositionstyps aus vtext',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LIEFERPOS_TYP_SPR_ZU PRIMARY KEY (mandant_id, lief_pos_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Lieferpositionstypen aus tvapt';

