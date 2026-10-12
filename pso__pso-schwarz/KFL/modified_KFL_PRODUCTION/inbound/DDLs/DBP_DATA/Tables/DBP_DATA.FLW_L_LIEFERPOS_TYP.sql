--==============================================================
-- Table: flw_l_lieferpos_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_lieferpos_typ
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_LIEFERPOS_TYP (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   lief_pos_typ_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Positionstyp Vertriebsbeleg z.Bsp. kostenlose Lieferung aus pstyv',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_LIEFERPOS_TYP PRIMARY KEY (mandant_id, lief_pos_typ_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup Tabelle der Lieferpositionstypen aus tvapt';

