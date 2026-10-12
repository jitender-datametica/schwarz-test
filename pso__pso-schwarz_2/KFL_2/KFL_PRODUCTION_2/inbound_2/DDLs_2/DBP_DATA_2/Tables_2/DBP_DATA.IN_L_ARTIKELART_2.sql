--==============================================================
-- Table: in_l_artikelart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_artikelart_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_ARTIKELART_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   artikelart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Ordnet das Material einer Gruppe_2 zu. Z.Bsp. HAWA, ZERL. Quelle ist mara.mtart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_ARTIKELART PRIMARY KEY (mandant_id, artikelart_id) NOT ENFORCED
)  COMMENT = 'BIS - Lookup Tabelle der Artikelarten aus dem Industriesystem, Quelle ist t134t';
