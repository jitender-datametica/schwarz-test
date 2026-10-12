--==============================================================
-- Table: lbs_gruppe_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_zek_zu_1
   generated from Powerdesigner on Montag, 5. August 2024 10:15:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_GRUPPE_ZEK_ZU_1 (
   MANDANT_ID                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   LBS_GRUPPE_ID                       NUMBER(38,0)     NOT NULL COMMENT 'ID der LBS-Einkäufergruppe. Gruppe_1 bündelt eine_1 oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich',
   ZEK_ID                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   ALLE_ZEK_FG                         NUMBER(38,0)     NOT NULL COMMENT 'Es signalisiert, dass dieser Gruppe_1 alle ZEK_1 eines Landes zugeteilt sind.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_GRUPPE_ZEK_ZU PRIMARY KEY (LBS_GRUPPE_ID, MANDANT_ID, ZEK_ID) NOT ENFORCED
)  COMMENT = 'Securitytabelle, KFL EK Fachbereich teilt LBS Einkäufergruppen je Land_1 eine_1 oder mehrere ZEK_Ids zu.';
