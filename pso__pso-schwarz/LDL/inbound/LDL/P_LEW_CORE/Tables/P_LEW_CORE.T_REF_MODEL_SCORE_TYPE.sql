/* --------------------------------------------------------------------------------
   DDL for table: t_ref_model_score_type
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 17:03:53
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_MODEL_SCORE_TYPE (
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL.',
   score_type_sid                      NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key SCORE TYPE.',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'Sprechender Code, CX, LDL+, AP.',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_REF_MODEL_SCORE_TYPE PRIMARY KEY (model_sid, score_type_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. This table contains the information which score will be calculated and used in which model.';
