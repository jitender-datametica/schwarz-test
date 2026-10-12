/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating_element_keyword
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:50:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_rating_element_keyword (
item_rating_element_keyword_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate identifier for the item rating element keyword record. the same keyword can be used multiple times in a sentence in similar context.'),
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
item_rating_element_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key STORE RATING ELEMENT.'),
src_item_rating_element_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item rating element in the system of the data provider.'),
keyword_unigram_txt STRING(1000) NOT NULL
OPTIONS(description='A word that is used in the rating comment and has been identified as key word'),
rating_keyword_type_cd STRING(100) NOT NULL
OPTIONS(description='Code for the discriminator values for keyword types used in rating.'),
keyword_bigram_txt STRING(1000)
OPTIONS(description='A 2 word combinaton consisting of the keyword and related significant word that is used in rating'),
keyword_trigram_txt STRING(1000)
OPTIONS(description='A 3 words combinaton from target word and related significant words that is used in rating'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (item_rating_element_keyword_sid) NOT ENFORCED
) OPTIONS(description='This table contains the keywords related to store rating elements.');