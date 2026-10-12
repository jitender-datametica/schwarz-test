/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating_element_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:49:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_rating_element_2 (
item_rating_element_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_2 RATING ELEMENT.'),
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
src_item_rating_element_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item_2 rating element in the system of the data provider.'),
item_rating_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for rating of an item.'),
item_rating_element_txt STRING(16000)
OPTIONS(description='Text given in the rating by the rater translated into English.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (item_rating_element_sid) NOT ENFORCED
)
OPTIONS(description='This table contains elements ( for example individual sentences of a rating comment) of item_2 ratings by real or potential customers giving their opinion about Lidl.             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.');