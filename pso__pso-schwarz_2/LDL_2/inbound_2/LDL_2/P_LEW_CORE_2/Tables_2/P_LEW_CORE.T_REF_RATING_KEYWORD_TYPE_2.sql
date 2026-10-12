/* --------------------------------------------------------------------------------
   DDL for table: t_ref_rating_keyword_type_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:52:37
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_RATING_KEYWORD_TYPE_2 (
   rating_keyword_type_cd              VARCHAR(100)     NOT NULL COMMENT 'Code for the discriminator values for keyword types used in rating.',
   rating_keyword_type_descr           VARCHAR(250)     NOT NULL COMMENT 'A textual description for the discriminator value for keyword types used in rating.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_REF_RATING_KEYWORD_TYPE PRIMARY KEY (rating_keyword_type_cd) NOT ENFORCED 
)  COMMENT = 'The minor dimension that contain keyword types used in rating ( for example Noun , Adjective , Verb , etc)';
