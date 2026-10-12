--==============================================================
-- Table: in_artikelart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_artikelart_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_ARTIKELART_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   artikelart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Ordnet das Material einer Gruppe zu. Z.Bsp. HAWA, ZERL. Quelle ist mara.mtart',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   artikelart_bez                      VARCHAR(40)      NOT NULL COLLATE 'en-ci',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_ARTIKELART_SPR_ZU PRIMARY KEY (mandant_id, artikelart_id, spr_id) NOT ENFORCED
)  COMMENT = 'BIS - Sprachabhängige Bezeichnungen der Artikelarten aus dem Industriesystem, Quelle ist t134t';
