/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating_element_keyword_1
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:50:05
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_RATING_ELEMENT_KEYWORD_1 (
   item_rating_element_keyword_sid     NUMBER(38,0)     NOT NULL COMMENT 'surrogate identifier for the item_1 rating element keyword record. the same keyword can be used multiple times in a sentence in similar context.',
   cx_info_provider_nr                 VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.',
   item_rating_element_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key STORE RATING ELEMENT.',
   src_item_rating_element_nr          VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item_1 rating element in the system of the data provider.',
   keyword_unigram_txt                 VARCHAR(1000)    NOT NULL COMMENT 'A word that is used in the rating comment and has been identified as key word',
   rating_keyword_type_cd              VARCHAR(100)     NOT NULL COMMENT 'Code for the discriminator values for keyword types used in rating.',
   keyword_bigram_txt                  VARCHAR(1000)    COMMENT 'A 2 word combinaton consisting of the keyword and related significant word that is used in rating',
   keyword_trigram_txt                 VARCHAR(1000)    COMMENT 'A 3 words combinaton from target word and related significant words that is used in rating',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_ITEM_RATING_ELEMENT_KEYWORD PRIMARY KEY (item_rating_element_keyword_sid) NOT ENFORCED 
)  COMMENT = 'This table contains the keywords related to store rating elements.';
