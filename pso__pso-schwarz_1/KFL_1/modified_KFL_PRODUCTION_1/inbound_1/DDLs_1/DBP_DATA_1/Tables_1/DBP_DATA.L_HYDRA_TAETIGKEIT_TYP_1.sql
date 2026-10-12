--==============================================================
-- Table: l_hydra_taetigkeit_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_taetigkeit_typ_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:12:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_HYDRA_TAETIGKEIT_TYP_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   taetigkeit_typ_id                   VARCHAR(1)       NOT NULL COMMENT 'BDE Verarbeitung der Tätigkeit ;Z=Zeitlohn ;D=Durchschnitt (code for activity payment type',
   taetigkeit_typ_bez                  VARCHAR(30)      COMMENT 'Bezeichnung der BDE-Verarbeitung (description of the activity payment type',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_HYDRA_TAETIGKEIT_TYP PRIMARY KEY (mandant_id, taetigkeit_typ_id) NOT ENFORCED
)  COMMENT = 'hydra_taetigkeit_typ describes how it is paid for a certain activity - Per hour, per piece of work done ...
             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table';
