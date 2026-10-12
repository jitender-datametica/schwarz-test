--==============================================================
-- Table: lbs_gruppe_gruppe_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_gruppe_zu
   generated from Powerdesigner on Montag, 5. August 2024 10:12:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_GRUPPE_GRUPPE_ZU (
   LBS_GRUPPE_ID                       NUMBER(38,0)     NOT NULL COMMENT 'ID der LBS-Einkäufergruppe. Gruppe bündelt eine oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich',
   LBS_GRUPPE_PARENT_ID                NUMBER(38,0)     NOT NULL COMMENT 'LBS-Einkäufergruppen können miteinander in Beziehung stehen.. "Parent_ID" ist die übergeordnete lbs_gruppe_id einer anderen LBS-Einkäufergruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_GRUPPE_GRUPPE_ZU PRIMARY KEY (LBS_GRUPPE_ID, LBS_GRUPPE_PARENT_ID) NOT ENFORCED
)  COMMENT = 'Securitytabelle, KFL EK Fachbereich pflegt die Beziehungen zwischen verschiedenen LBS Einkäufergruppen.';
