--==============================================================
-- Table: lbs_gruppe_zek_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_zek_zu
   generated from Powerdesigner on Montag, 5. August 2024 10:15:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_GRUPPE_ZEK_ZU (
   MANDANT_ID                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   LBS_GRUPPE_ID                       INTEGER     NOT NULL COMMENT 'ID der LBS-Einkäufergruppe. Gruppe bündelt eine oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich',
   ZEK_ID                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   ALLE_ZEK_FG                         INTEGER     NOT NULL COMMENT 'Es signalisiert, dass dieser Gruppe alle ZEK eines Landes zugeteilt sind.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_GRUPPE_ZEK_ZU PRIMARY KEY (LBS_GRUPPE_ID, MANDANT_ID, ZEK_ID) NOT ENFORCED
)  COMMENT = 'Securitytabelle, KFL EK Fachbereich teilt LBS Einkäufergruppen je Land eine oder mehrere ZEK_Ids zu.';
