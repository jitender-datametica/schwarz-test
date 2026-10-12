--==============================================================
-- Table: gruppe_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gruppe_zek_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:20:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.GRUPPE_ZEK_ZU_1 (
   gruppe_id                           INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Usergruppe',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   alle_zek_fg                         INTEGER     COMMENT 'User dieser Gruppe_1 werden allen zeks zugeordnet.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GRUPPE_ZEK_ZU PRIMARY KEY (gruppe_id, zek_id, mandant_id) NOT ENFORCED
)  COMMENT = 'AIS KMO - Securitytabelle zur Pflege von Usergruppen';
