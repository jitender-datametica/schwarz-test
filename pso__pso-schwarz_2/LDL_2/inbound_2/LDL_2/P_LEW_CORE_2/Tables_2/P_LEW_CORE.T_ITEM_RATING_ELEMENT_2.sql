/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating_element_2
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:49:45
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_RATING_ELEMENT_2 (
   item_rating_element_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM_2 RATING ELEMENT.',
   cx_info_provider_nr                 VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.',
   src_item_rating_element_nr          VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item_2 rating element in the system of the data provider.',
   item_rating_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating of an item.',
   item_rating_element_txt             VARCHAR(16000)   COMMENT 'Text given in the rating by the rater translated into English.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_ITEM_RATING_ELEMENT PRIMARY KEY (item_rating_element_sid) NOT ENFORCED 
)  COMMENT = 'This table contains elements ( for example individual sentences of a rating comment) of item_2 ratings by real or potential customers giving their opinion about Lidl.
             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.';
