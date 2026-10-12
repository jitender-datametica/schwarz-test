--==============================================================
-- Table: geku_gebietsleiter_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_gebietsleiter_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_GEBIETSLEITER_2 (
   gebietsleiter_uid                   NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID des Gebietsleiters aus pc_nr',
   vertriebsbuero_uid                  NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines Vertriebsbüros aus rvl_nr',
   gebietsleiter_bez                   VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Gebietsleiters',
   berichts_empfaenger_ldap            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'LDAP für den automatischen Versand von Berichten für den Gebietsleiter',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_GEBIETSLEITER PRIMARY KEY (gebietsleiter_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Lookup-Tabelle der Gebietsleiter aus wmd_pc_out';

