--==============================================================
-- Table: fakturaart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fakturaart_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FAKTURAART_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   fakturaart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Klassifiziert verschiedene Arten von Fakturabelegen, die eine unterschiedliche Verarbeitung durch das System erfordern.',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   fakturaart_bez                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' DEFAULT '                    ' COMMENT 'Sprachabhängiger Kurztext für die Arten der Fakturabelege.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FAKTURAART_SPR_ZU PRIMARY KEY (mandant_id, fakturaart_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Arten der Fakturabelege enthalten. - MULTISET';

