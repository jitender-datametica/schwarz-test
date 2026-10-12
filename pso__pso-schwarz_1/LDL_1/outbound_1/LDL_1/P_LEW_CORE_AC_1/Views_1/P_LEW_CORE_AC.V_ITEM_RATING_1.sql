CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_rating_1 (item_rating_sid
OPTIONS(description='Surrogate Key for rating of an item_1'), cx_info_provider_nr
OPTIONS(description='Identifier of the provider or collector of the customer experience information.'),
src_item_rating_nr OPTIONS(description='Identifier of the item_1 rating event in the system of the data provider.'),
model_sid OPTIONS(description='Surrogate Key MODEL.'), model_area_cd
OPTIONS(description='Sprechender Code, CX, LDL+, AP.'), model_group_cd
OPTIONS(description='Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.'), int_org_sid
OPTIONS(description='surrogate key internal organisation, here only NFPO organisatiions are used'), item_ian_nr
OPTIONS(description='Lidl International Item_1 Number.'), item_rating_dt
OPTIONS(description='Date of the item_1 rating event.'), item_rating_txt
OPTIONS(description='Text given in the rating by the rater translated into English.'), dwh_load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.'), dwh_created
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'))
OPTIONS(DESCRIPTION = `THIS TABLE CONTAINS ITEMS RATINGS BY REAL OR POTENTIAL CUSTOMERS GIVING THEIR OPINION ABOUT PRODUCTS OF LIDL.             THESE RATINGS ARE PROVIDED BY CERTAIN SEVICE PROVIDERS (PREDICT, MEDALLIA, GOOGLE, ...) AND ARE AVAILABLE FOR BOTH LIDL STATIONARY AND LIDL DIGITAL ARTICLES.`)
AS SELECT item_rating_sid,
 cx_info_provider_nr,
 src_item_rating_nr,
 model_sid,
 model_area_cd,
 model_group_cd,
 int_org_sid,
 item_ian_nr,
 item_rating_dt,
 item_rating_txt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_rating_1;