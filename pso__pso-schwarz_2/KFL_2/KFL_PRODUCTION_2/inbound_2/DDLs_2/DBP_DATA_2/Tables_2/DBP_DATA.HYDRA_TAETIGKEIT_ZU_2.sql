--==============================================================
-- Table: hydra_taetigkeit_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_taetigkeit_zu_2
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:17:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HYDRA_TAETIGKEIT_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   pers_teilbereich_id                 VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   taetigkeit_id                       VARCHAR(3)       NOT NULL COMMENT 'Tätigkeit ID (mit führenden Nullen, z.B. 001) (local activity type code)',
   taetigkeit_bez                      VARCHAR(30)      NOT NULL COMMENT 'Bezeichnung der Tätigkeit (description of the local activity)',
   taetigkeit_typ_id                   VARCHAR(1)       NOT NULL COMMENT 'BDE Verarbeitung der Tätigkeit ;Z=Zeitlohn ;D=Durchschnitt (code for activity payment type)',
   taetigkeit_int_id                   NUMBER(38,0)     NOT NULL COMMENT 'Internationale Tätigkeit ID ( International/group Activity Type code)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HYDRA_TAETIGKEIT_ZU PRIMARY KEY (mandant_id, pers_teilbereich_id, taetigkeit_id) NOT ENFORCED
)  COMMENT = 'Local code for the Activity Type. Here for every local code we have which is the corresponding group code.
             ';
