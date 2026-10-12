--==============================================================
-- Table: fw_wk_national_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_wk_national_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FW_WK_NATIONAL_SPR_ZU_2 (
   fw_wk_national_id                   VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung aus text, z.Bsp. Renner Ost',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wg_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   fw_wk_national_bez                  VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für den Artikelkennzeichen Fleischwerk WK-National z.Bsp. Renner West aus text',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FW_WK_NATIONAL_SPR_ZU PRIMARY KEY (fw_wk_national_id, mandant_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Fleischwerk WK  National Artikelkennzeichen aus der Retail Tabelle  zfwprwaren
             ';

