CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_rating_element_2 (item_rating_element_sid
OPTIONS(description='Surrogate Key ITEM_2 RATING ELEMENT.'), cx_info_provider_nr
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
src_item_rating_element_nr
OPTIONS(description='Identifier of the item_2 rating element in the system of the data provider.'), item_rating_sid
OPTIONS(description='Surrogate Key for rating of an item.'), item_rating_element_txt
OPTIONS(description='Text given in the rating by the rater translated into English.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS ELEMENTS ( FOR EXAMPLE INDIVIDUAL SENTENCES OF A RATING COMMENT) OF ITEM_2 RATINGS BY REAL OR POTENTIAL CUSTOMERS GIVING THEIR OPINION ABOUT LIDL.             THESE RATINGS ARE PROVIDED BY CERTAIN SEVICE PROVIDERS (PREDICT, MEDALLIA, GOOGLE, ...) AND ARE AVAILABLE FOR BOTH LIDL STATIONARY AND LIDL DIGITAL ARTICLES.`)
AS SELECT item_rating_element_sid,
 cx_info_provider_nr,
 src_item_rating_element_nr,
 item_rating_sid,
 item_rating_element_txt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_rating_element_2;