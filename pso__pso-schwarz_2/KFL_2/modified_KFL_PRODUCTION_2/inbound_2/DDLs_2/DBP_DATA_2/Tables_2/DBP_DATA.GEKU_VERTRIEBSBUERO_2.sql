--==============================================================
-- Table: geku_vertriebsbuero_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_vertriebsbuero_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_VERTRIEBSBUERO_2 (
   vertriebsbuero_uid                  INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Vertriebsbüros aus rvl_nr',
   country_uid                         INTEGER     NOT NULL COMMENT 'Eindeutige ID des Landes aus country_nr',
   vertriebsbuero_bez                  VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Vertriebsbüros',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_VERTRIEBSBUERO PRIMARY KEY (vertriebsbuero_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Lookup Tabelle der Vertriebsbüros aus wmd_rvl_out';
