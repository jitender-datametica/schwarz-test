/* --------------------------------------------------------------------------------
   DDL for table: t_item_rating
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:49:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_rating (
item_rating_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for rating of an item'),
cx_info_provider_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
src_item_rating_nr STRING(100) NOT NULL
OPTIONS(description='Identifier of the item rating event in the system of the data provider.'),
model_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MODEL.'),
model_area_cd STRING(100) NOT NULL OPTIONS(description='Sprechender Code, CX, LDL+, AP.'),
model_group_cd STRING(100) NOT NULL
OPTIONS(description='Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key internal organisation, here only NFPO organisatiions are used'),
item_ian_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lidl International Item Number.'),
item_rating_dt DATE NOT NULL OPTIONS(description='Date of the item rating event.'),
item_rating_txt STRING(16000) OPTIONS(description='Text given in the rating by the rater translated into English.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
PRIMARY KEY (item_rating_sid) NOT ENFORCED
)
OPTIONS(description='This table contains items ratings by real or potential customers giving their opinion about products of Lidl.             These ratings are provided by certain sevice providers (Predict, Medallia, Google, ...) and are available for both Lidl Stationary and Lidl Digital articles.');