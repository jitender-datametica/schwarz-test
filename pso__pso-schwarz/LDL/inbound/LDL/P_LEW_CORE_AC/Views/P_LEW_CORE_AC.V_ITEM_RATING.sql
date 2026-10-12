CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_RATING
(
   item_rating_sid                      COMMENT 'Surrogate Key for rating of an item'
   ,cx_info_provider_nr                 COMMENT 'Identifier of the provider or collector of the customer experience information.'
   ,src_item_rating_nr                  COMMENT 'Identifier of the item rating event in the system of the data provider.'
   ,model_sid                           COMMENT 'Surrogate Key MODEL.'
   ,model_area_cd                       COMMENT 'Sprechender Code, CX, LDL+, AP.'
   ,model_group_cd                      COMMENT 'Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'
   ,int_org_sid                         COMMENT 'surrogate key internal organisation, here only NFPO organisatiions are used'
   ,item_ian_nr                         COMMENT 'Lidl International Item Number.'
   ,item_rating_dt                      COMMENT 'Date of the item rating event.'
   ,item_rating_txt                     COMMENT 'Text given in the rating by the rater translated into English.'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
) COMMENT = 'This table contains items ratings by real or potential customers giving their opinion about products of Lidl.
             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.'
AS 
    SELECT 
        item_rating_sid
        ,cx_info_provider_nr
        ,src_item_rating_nr
        ,model_sid
        ,model_area_cd
        ,model_group_cd
        ,int_org_sid
        ,item_ian_nr
        ,item_rating_dt
        ,item_rating_txt
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_ITEM_RATING ;
