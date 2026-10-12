--==============================================================
-- Table: fw_wk_system_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fw_wk_system_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FW_WK_SYSTEM_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   fw_wk_system_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Fleischwerk WK Artikelkennzeichens aus zzfwbeschaf, z.Bsp. Innereien',
   wg_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   fw_wk_system_bez                    VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für den Artikelkennzeichen Fleischwerk WK-System z.Bsp. Rindfleisch aus text',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FW_WK_SYSTEM_SPR_ZU PRIMARY KEY (mandant_id, fw_wk_system_id, wg_id, arthiertyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen für Fleischwer WK Artikelkennzeichen aus der Retail Tabelle zfwwprbesch
             ';

