--==============================================================
-- Table: lbs_gruppe_user_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_user_zu
   generated from Powerdesigner on Donnerstag, 3. Juli 2025 23:59:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_GRUPPE_USER_ZU (
   lbs_gruppe_id                       INTEGER     NOT NULL COMMENT 'ID der LBS-Einkäufergruppe. Gruppe bündelt eine oder mehrere ZEKs gem. Pflege aus dem KFL-EK Fachbereich',
   user_id                             VARCHAR(30)      NOT NULL COMMENT 'LDAP des User, für welchen die ZEK Zugehörigkeit gepflegt wird.',
   dat_gueltig_bis                     DATE             NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Das Feld zeigt an, bis zu welchem Tag die Zugehörigkeit eines Users zur Einkäufer-Securitygruppe gültig ist. Per default ist eine Gruppenzugehörigkeit immer bis Unendlich ''9999-12-31'' gültig, es sei denn das KFL Security Team pflegt explizit ein anderes Datum über den Transaktionsbericht.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_GRUPPE_USER_ZU PRIMARY KEY (lbs_gruppe_id, user_id) NOT ENFORCED
)  COMMENT = 'Securitytabelle, KFL EK Fachbereich pflegt die Zugehörigkeit eines Users (LDAP) zu einer oder mehreren LBS Einkäufergruppen.';
