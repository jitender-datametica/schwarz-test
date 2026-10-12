--==============================================================
-- Table: d_gruppe_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: d_gruppe_zek_zu
   generated from Powerdesigner on Donnerstag, 7. September 2023 15:34:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DIALOG.D_GRUPPE_ZEK_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   gruppe_id                           NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID einer Usergruppe',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   loesch_fg                           NUMBER(38,0)     COMMENT 'Anforderung zur Löschung',
   alle_zek_fg                         NUMBER(38,0)     COMMENT 'User dieser Gruppe werden allen zeks zugeordnet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_D_GRUPPE_ZEK_ZU PRIMARY KEY (mandant_id, gruppe_id, zek_id) NOT ENFORCED
)  COMMENT = 'AIS KMO - Dialogtabelle zur Pflege von Usergruppen';
