/* --------------------------------------------------------------------------------
   DDL for table: t_model_rating_score_type_1
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:52:53
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MODEL_RATING_SCORE_TYPE_1 (
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL',
   rating_score_type_sid               NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key RATING SCORE TYPE',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_MODEL_RATING_SCORE_TYPE PRIMARY KEY (model_sid, rating_score_type_sid) NOT ENFORCED 
)  COMMENT = 'this table contains the information which rating score will be calculated and used in which model';
