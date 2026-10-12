/* --------------------------------------------------------------------------------
   DDL for table: t_ref_lil_period_type_descr_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_LIL_PERIOD_TYPE_DESCR_2 (
   period_type_id                      NUMBER(38,0)     NOT NULL COMMENT 'Perioden-Typ-ID',
   lang_cd                             VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Sprache - Code',
   period_type_name                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Beschreibung Perioden-Typ',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',   
   CONSTRAINT PK_T_REF_LIL_PERIOD_TYPE_DESCR PRIMARY KEY (period_type_id, lang_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ This minor entity defines the subtype discriminators for periods in the LIAM/LIFT / CM context. ';

