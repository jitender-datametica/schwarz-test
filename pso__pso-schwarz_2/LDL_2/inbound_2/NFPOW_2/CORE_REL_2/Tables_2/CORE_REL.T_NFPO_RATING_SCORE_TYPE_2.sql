/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_rating_score_type_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:30:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_RATING_SCORE_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_rating_score_type_sid          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO RATING SCORE TYPE
            LDL: p_lew_core.t_ref_rating_score_type.rating_score_type_sid',
   nfpo_rating_score_type_name         VARCHAR(100)     NOT NULL COMMENT 'Name of the nfpo rating score type
            LDL: p_lew_core.t_ref_rating_score_type.rating_score_type_name',
   nfpo_rating_score_type_descr        VARCHAR(250)     NOT NULL COMMENT 'Description of the nfpo rating score type
            LDL: p_lew_core.t_ref_rating_score_type.raqting_score_type_descr',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: p_lew_core.t_ref_rating_score_type..DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: p_lew_core.t_ref_rating_score_type..DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_RATING_SCORE_TYPE PRIMARY KEY (nfpo_rating_score_type_sid) NOT ENFORCED 
)  COMMENT = 'This table contains rating score types. A rating score type is a certain well defined calculation which will be calculated if a rating model is applied. The result will be stored as an intermediate or final result to allow the assignement of entities to rating classes.
             LDL: p_lew_core.t_ref_rating_score_type_2';
