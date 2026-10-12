--==============================================================
-- Table: discountart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: discountart_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISCOUNTART_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   discountart_id                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID Discountart',
   discountart_bez                     VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT '' COMMENT 'Bezeichnung der Discountart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISCOUNTART_SPR_ZU PRIMARY KEY (mandant_id, discountart_id) NOT ENFORCED
)  COMMENT = 'EK - Sprachzuordnungstabelle für Discountart';

