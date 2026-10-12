--==============================================================
-- Table: fw_wk_discount_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_wk_discount_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FW_WK_DISCOUNT_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   fw_wk_discount_id                   VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'ID für die Kennzeichnung fw_wk_discount aus dem Quellfeld zfwqualita',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   fw_wk_discount_bez                  VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für den Artikelkennzeichen Fleischwerk WK-Discount z.Bsp. Purland aus text',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FW_WK_DISCOUNT_SPR_ZU PRIMARY KEY (mandant_id, fw_wk_discount_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Fleischwerk WK  Discount Artikelkennzeichen aus der Retail Tabelle  zfwprquali
             ';

