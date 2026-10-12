CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_RATING_ELEMENT_1
(
   item_rating_element_sid               COMMENT 'Surrogate Key ITEM_1 RATING ELEMENT.'
   ,cx_info_provider_nr                  COMMENT 'Identifier of the provider or collector of the customer experience information.'
   ,src_item_rating_element_nr           COMMENT 'Identifier of the item_1 rating element in the system of the data provider.'
   ,item_rating_sid                      COMMENT 'Surrogate Key for rating of an item.'
   ,item_rating_element_txt              COMMENT 'Text given in the rating by the rater translated into English.'
   ,dwh_load_id                          COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created                          COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated                          COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
) COMMENT = 'This table contains elements ( for example individual sentences of a rating comment) of item_1 ratings by real or potential customers giving their opinion about Lidl.
             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.'
AS 
    SELECT 
        item_rating_element_sid
        ,cx_info_provider_nr
        ,src_item_rating_element_nr
        ,item_rating_sid
        ,item_rating_element_txt
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_ITEM_RATING_ELEMENT_1 ;
