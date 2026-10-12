/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:49:24
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_RATING (
   item_rating_sid                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for rating of an item',
   cx_info_provider_nr                 VARCHAR(100)     NOT NULL COMMENT 'Identifier of the provider or collector of the customer experience information.',
   src_item_rating_nr                  VARCHAR(100)     NOT NULL COMMENT 'Identifier of the item rating event in the system of the data provider.',
   model_sid                           NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key MODEL.',
   model_area_cd                       VARCHAR(100)     NOT NULL COMMENT 'Sprechender Code, CX, LDL+, AP.',
   model_group_cd                      VARCHAR(100)     NOT NULL COMMENT 'Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.',
   int_org_sid                         NUMBER(38,0)     NOT NULL COMMENT 'surrogate key internal organisation, here only NFPO organisatiions are used',
   item_ian_nr                         NUMBER(38,0)     NOT NULL COMMENT 'Lidl International Item Number.',
   item_rating_dt                      DATE             NOT NULL COMMENT 'Date of the item rating event.',
   item_rating_txt                     VARCHAR(16000)   COMMENT 'Text given in the rating by the rater translated into English.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_ITEM_RATING PRIMARY KEY (item_rating_sid) NOT ENFORCED 
)  COMMENT = 'This table contains items ratings by real or potential customers giving their opinion about products of Lidl.
             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.';
