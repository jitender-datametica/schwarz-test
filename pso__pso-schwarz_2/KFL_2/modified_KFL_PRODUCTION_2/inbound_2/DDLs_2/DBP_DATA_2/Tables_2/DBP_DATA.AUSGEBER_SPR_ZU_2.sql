--==============================================================
-- Table: ausgeber_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausgeber_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSGEBER_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   ausgeber_typ_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Ausgebers, es gibt KDC, TIP und Filiale',
   ausgeber_id                         VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichnung des Gutschein_2-Ausgebers (Seller), z.Bsp. TIP001',
   spr_id                              INTEGER     NOT NULL COMMENT 'Nummer der Sprache',
   ausgeber_bez                        VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Gutschein_2-Ausgebers, z.Bsp. Kulanz. Bei einer Filiale die Filialbezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSGEBER_SPR_ZU PRIMARY KEY (mandant_id, ausgeber_typ_id, ausgeber_id, spr_id) NOT ENFORCED
)  COMMENT = 'VIS - Bezeichnung der Gutscheinausgeber (Seller)';

