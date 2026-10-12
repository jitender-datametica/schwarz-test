CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ITEM_RATING_ELEMENT_KEYWORD_1
(
   item_rating_element_keyword_sid      COMMENT 'surrogate identifier for the item_1 rating element keyword record. the same keyword can be used multiple times in a sentence in similar context.'
   ,cx_info_provider_nr                 COMMENT 'Identifier of the provider or collector of the customer experience information.'
   ,item_rating_element_sid             COMMENT 'Surrogate Key STORE RATING ELEMENT.'
   ,src_item_rating_element_nr          COMMENT 'Identifier of the item_1 rating element in the system of the data provider.'
   ,keyword_unigram_txt                 COMMENT 'A word that is used in the rating comment and has been identified as key word'
   ,rating_keyword_type_cd              COMMENT 'Code for the discriminator values for keyword types used in rating.'
   ,keyword_bigram_txt                  COMMENT 'A 2 word combinaton consisting of the keyword and related significant word that is used in rating'
   ,keyword_trigram_txt                 COMMENT 'A 3 words combinaton from target word and related significant words that is used in rating'
   ,dwh_load_id                         COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'
   ,dwh_created                         COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'
   ,dwh_updated                         COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.'
) COMMENT = 'This table contains the keywords related to store rating elements.'
AS 
    SELECT 
        item_rating_element_keyword_sid
        ,cx_info_provider_nr
        ,item_rating_element_sid
        ,src_item_rating_element_nr
        ,keyword_unigram_txt
        ,rating_keyword_type_cd
        ,keyword_bigram_txt
        ,keyword_trigram_txt
        ,dwh_load_id
        ,dwh_created
        ,dwh_updated

FROM P_LEW_CORE.T_ITEM_RATING_ELEMENT_KEYWORD_1 ;
