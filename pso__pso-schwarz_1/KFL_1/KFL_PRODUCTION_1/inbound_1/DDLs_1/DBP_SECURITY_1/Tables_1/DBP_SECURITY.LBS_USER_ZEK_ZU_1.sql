--==============================================================
-- Table: lbs_user_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_user_zek_zu_1
   generated from Powerdesigner on Montag, 5. August 2024 10:16:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_USER_ZEK_ZU_1 (
   MANDANT_ID                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   ZEK_ID                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   USER_ID                             VARCHAR(30)      NOT NULL COMMENT 'LDAP des User, für welchen die ZEK_1 Zugehörigkeit gepflegt wird.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_USER_ZEK_ZU PRIMARY KEY (MANDANT_ID, ZEK_ID, USER_ID) NOT ENFORCED
)  COMMENT = 'Zuordnung von User zu Zentraleinkäufer für die Anzeigeberechtigung auf deren Lieferantent.';
