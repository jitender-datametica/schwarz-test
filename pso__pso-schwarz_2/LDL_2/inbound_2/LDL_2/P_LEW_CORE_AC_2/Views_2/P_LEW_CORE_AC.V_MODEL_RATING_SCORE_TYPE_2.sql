CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MODEL_RATING_SCORE_TYPE_2
(
   model_sid                            COMMENT 'Surrogate Key MODEL'
   ,rating_score_type_sid               COMMENT 'Surrogate Key RATING SCORE TYPE'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
) COMMENT = 'this table contains the information which rating score will be calculated and used in which model'
AS 
    SELECT 
        model_sid
        ,rating_score_type_sid
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_MODEL_RATING_SCORE_TYPE_2 ;
