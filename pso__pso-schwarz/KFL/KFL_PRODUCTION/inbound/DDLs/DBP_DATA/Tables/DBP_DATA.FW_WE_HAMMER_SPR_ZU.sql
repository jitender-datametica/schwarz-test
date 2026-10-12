--==============================================================
-- Table: fw_we_hammer_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_we_hammer_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FW_WE_HAMMER_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   fw_we_hammer_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'ID für die Kennzeichnung Fleischwerk WE-Hammer aus dem Quellfeld zfwveredel',
   wg_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   fw_we_hammer_bez                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für das Artikelkennzeichen Fleischwerk WE-Hammer aus dem Quellfeld Text, z.Bsp. FLW Osterfeld',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FW_WE_HAMMER_SPR_ZU PRIMARY KEY (mandant_id, fw_we_hammer_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Fleischwerk WE-Hammer Artikelkennzeichen aus der Retail Tabelle  zfwprvered';

