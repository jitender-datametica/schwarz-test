CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_RATING_ELEMENT_SCORE
(
   item_rating_element_sid              COMMENT 'Surrogate Key ITEM RATING ELEMENT.'
   ,rating_score_type_sid               COMMENT 'Surrogate Key RATING SCORE TYPE.'
   ,rating_score_meas                   COMMENT 'Value of the calculated rating score.'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
) COMMENT = 'This table contains the rating scores calculated for rating elements for a certain item rating using a model.'
AS 
    SELECT 
        item_rating_element_sid
        ,rating_score_type_sid
        ,rating_score_meas
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_ITEM_RATING_ELEMENT_SCORE ;
