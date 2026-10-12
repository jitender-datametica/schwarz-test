--==============================================================
-- Table: lbs_gruppe_user_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_user_zu_1
   generated from Powerdesigner on Donnerstag, 3. Juli 2025 23:59:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_GRUPPE_USER_ZU_1 (
   lbs_gruppe_id                       NUMBER(38,0)     NOT NULL COMMENT 'ID der LBS-Einkäufergruppe. Gruppe_1 bündelt eine_1 oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich',
   user_id                             VARCHAR(30)      NOT NULL COMMENT 'LDAP des User, für welchen die ZEK_1 Zugehörigkeit gepflegt wird.',
   dat_gueltig_bis                     DATE             NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Das Feld zeigt an, bis zu welchem Tag_1 die Zugehörigkeit eines Users zur Einkäufer-Securitygruppe gültig ist. Per default ist eine_1 Gruppenzugehörigkeit immer bis Unendlich ''9999-12-31'' gültig, es sei denn das KFL Security Team pflegt explizit ein anderes Datum über den Transaktionsbericht.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_GRUPPE_USER_ZU PRIMARY KEY (lbs_gruppe_id, user_id) NOT ENFORCED
)  COMMENT = 'Securitytabelle, KFL EK Fachbereich pflegt die Zugehörigkeit eines Users (LDAP) zu einer oder mehreren LBS Einkäufergruppen.';
