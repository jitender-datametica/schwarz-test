--==============================================================
-- Table: geku_ges_vertriebsltg_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_ges_vertriebsltg_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_GES_VERTRIEBSLTG_2 (
   country_uid                         INTEGER     NOT NULL COMMENT 'Eindeutige ID des Landes aus country_nr',
   land_iso                            VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ISO - Kürzel des Landes (z.Bsp. DE)',
   land_bez                            VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Landes',
   verteiltag_id                       INTEGER     COMMENT 'Entspricht der wtag_id des Datenmodells. Von 1 bis 7, wobei Montag = 1',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_GES_VERTRIEBSLTG PRIMARY KEY (country_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Lookup Tabelle der Gesamtvertriebsleitung';

