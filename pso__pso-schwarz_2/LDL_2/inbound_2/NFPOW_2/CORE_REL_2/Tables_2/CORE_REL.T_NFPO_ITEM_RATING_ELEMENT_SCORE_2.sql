/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_rating_element_score_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:31:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_RATING_ELEMENT_SCORE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_rating_element_sid        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating element of an item_2
            LDL: p_lew_core.item_rating_element_score.item_rating_element_sid',
   nfpo_rating_score_type_sid          NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO RATING SCORE TYPE
            LDL: p_lew_core.t_ref_rating_element_score.rating_score_type_sid',
   nfpo_rating_score_meas              NUMBER(38,5)     NOT NULL COMMENT 'Value of the calculated rating element score.
            LDL: p_lew_core.t_item_rating_element_score.item_rating_score_meas',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: LDL: p_lew_core.t_item_rating.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: LDL: p_lew_core.t_item_rating.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_RATING_ELEMENT_SCORE PRIMARY KEY (nfpo_item_rating_element_sid, nfpo_rating_score_type_sid) NOT ENFORCED 
)  COMMENT = 'This table contains the rating scores calculated for rating elements for a certain item_2 rating using a model.
             LDL: p_lew_core.t_item_rating_element_score_2';
