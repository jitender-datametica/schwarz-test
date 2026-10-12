--==============================================================
-- Table: fw_we_artikel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_we_artikel_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FW_WE_ARTIKEL_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   fw_we_artikel_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'ID für die Kennzeichnung Fleischwerk WE-Artikel_1 aus dem Quellfeld zfwprzuber',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   fw_we_artikel_bez                   VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für das Artikelkennzeichen Fleischwerk WE-Artikel_1  aus dem Quellfeld Text, z.Bsp. Eigenproduktion',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FW_WE_ARTIKEL_SPR_ZU PRIMARY KEY (mandant_id, fw_we_artikel_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Fleischwerk WE-Artikel_1 Artikelkennzeichen aus der Retail Tabelle  zfwprzuber';

