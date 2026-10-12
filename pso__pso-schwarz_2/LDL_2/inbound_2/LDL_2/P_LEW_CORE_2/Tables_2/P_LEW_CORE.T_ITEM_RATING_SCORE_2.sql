/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating_score_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:50:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_RATING_SCORE_2 (
   item_rating_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating of an item.',
   rating_score_type_sid               NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key RATING SCORE TYPE.',
   rating_score_meas                   NUMBER(38,5)     NOT NULL COMMENT 'Value of the calculated rating score.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_ITEM_RATING_SCORE PRIMARY KEY (rating_score_type_sid, item_rating_sid) NOT ENFORCED 
)  COMMENT = 'This table contains the rating scores calculated for a certain item_2 rating using a model.';
