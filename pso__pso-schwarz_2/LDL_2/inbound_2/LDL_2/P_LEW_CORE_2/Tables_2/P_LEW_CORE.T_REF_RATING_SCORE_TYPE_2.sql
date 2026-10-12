/* --------------------------------------------------------------------------------
   DDL for table: t_ref_rating_score_type_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:52:16
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_RATING_SCORE_TYPE_2 (
   rating_score_type_sid               NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key RATING SCORE TYPE',
   rating_score_type_name              VARCHAR(100)     NOT NULL COMMENT 'Name of the rating score type',
   rating_score_type_descr             VARCHAR(250)     NOT NULL COMMENT 'Description of the rating score type',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_REF_RATING_SCORE_TYPE PRIMARY KEY (rating_score_type_sid) NOT ENFORCED 
)  COMMENT = 'This table contains rating score types. A rating score type is a certain well defined calculation which will be calculated if a rating model is applied. The result will be stored as an intermediate or final result to allow the assignement of entities to rating classes.';
