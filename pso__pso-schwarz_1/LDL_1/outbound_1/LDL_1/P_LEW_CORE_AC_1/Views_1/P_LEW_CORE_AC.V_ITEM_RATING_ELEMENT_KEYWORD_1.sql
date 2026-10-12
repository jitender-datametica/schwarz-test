CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_rating_element_keyword_1 (item_rating_element_keyword_sid
OPTIONS(description='surrogate identifier for the item_1 rating element keyword record. the same keyword can be used multiple times in a sentence in similar context.'),
cx_info_provider_nr
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
item_rating_element_sid OPTIONS(description='Surrogate Key STORE RATING ELEMENT.'), src_item_rating_element_nr
OPTIONS(description='Identifier of the item_1 rating element in the system of the data provider.'), keyword_unigram_txt
OPTIONS(description='A word that is used in the rating comment and has been identified as key word'),
rating_keyword_type_cd OPTIONS(description='Code for the discriminator values for keyword types used in rating.'),
keyword_bigram_txt
OPTIONS(description='A 2 word combinaton consisting of the keyword and related significant word that is used in rating'),
keyword_trigram_txt
OPTIONS(description='A 3 words combinaton from target word and related significant words that is used in rating'),
dwh_load_id OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS THE KEYWORDS RELATED TO STORE RATING ELEMENTS.`) AS SELECT
 item_rating_element_keyword_sid,
 cx_info_provider_nr,
 item_rating_element_sid,
 src_item_rating_element_nr,
 keyword_unigram_txt,
 rating_keyword_type_cd,
 keyword_bigram_txt,
 keyword_trigram_txt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_rating_element_keyword_1;