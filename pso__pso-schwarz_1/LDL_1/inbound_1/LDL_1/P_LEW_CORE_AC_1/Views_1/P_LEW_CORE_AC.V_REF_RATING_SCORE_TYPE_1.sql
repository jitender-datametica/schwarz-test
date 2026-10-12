CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_RATING_SCORE_TYPE_1
(
   rating_score_type_sid                COMMENT 'Surrogate Key RATING SCORE TYPE'
   ,rating_score_type_name              COMMENT 'Name of the rating score type'
   ,rating_score_type_descr             COMMENT 'Description of the rating score type'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
) COMMENT = 'This table contains rating score types. A rating score type is a certain well defined calculation which will be calculated if a rating model is applied. The result will be stored as an intermediate or final result to allow the assignement of entities to rating classes.'
AS 
    SELECT 
        rating_score_type_sid
        ,rating_score_type_name
        ,rating_score_type_descr
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_REF_RATING_SCORE_TYPE_1 ;
