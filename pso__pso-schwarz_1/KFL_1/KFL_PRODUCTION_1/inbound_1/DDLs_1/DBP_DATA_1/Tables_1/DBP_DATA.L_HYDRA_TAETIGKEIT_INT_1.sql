--==============================================================
-- Table: l_hydra_taetigkeit_int_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_taetigkeit_int_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:12:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_HYDRA_TAETIGKEIT_INT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   taetigkeit_int_id                   NUMBER(38,0)     NOT NULL COMMENT 'Internationale Tätigkeit ID ( International/group Activity Type code)',
   taetigkeit_int_bez                  VARCHAR(30)      COMMENT 'Internationale Bezeichnung der Tätigkeit (description of the code)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_HYDRA_TAETIGKEIT_INT PRIMARY KEY (mandant_id, taetigkeit_int_id) NOT ENFORCED
)  COMMENT = 'Internetional/Group code for the Activity Type. Every warehouse has it''s own local  Activity Types ( hydra_taetigkeit_zu_1 ),  There for every local code we have which is the corresponding group code.
             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table';
