--==============================================================
-- Table: coi_l_ump_referenz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_l_ump_referenz
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_L_UMP_REFERENZ (
   referenzgrund_id                    NUMBER(38,0)     NOT NULL COMMENT 'Die ID für den Grund warum eine Referenzfiliale herangezogen wurde',
   referenzgrund_bez                   VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Grundes warum eine Referenzfiliale herangezogen wurde',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_L_UMP_REFERENZ PRIMARY KEY (referenzgrund_id) NOT ENFORCED
)  COMMENT = 'Lookup Tabelle für die Referenzgründe die als Dropdown-Feld in der Uploadexel vom Fachbereich ausgewählt werden können, warum an gewissen Stellen eine Referenzfiliale ausgewählt wird';

