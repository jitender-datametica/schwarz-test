/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_activity_plan_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign_element_activity_plan_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
campaign_elem_plan_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for an activity that is planned within a certain campaign element.'),
campaign_elem_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the campaign element.'),
campaign_activity_type_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='The discriminator code for campaign activities.'),
plan_status_cd STRING(6) COLLATE 'und:ci' NOT NULL
OPTIONS(description='A code uniquely identifying the status_1 of a planned campaign activity.'),
price_active_from_dt DATE OPTIONS(description='The begin date of the (planned) price reduction period.'),
price_active_to_dt DATE OPTIONS(description='The end date of the (planned) price reduction period.'),
sales_channel_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) of the sales_1 channel, for which the price change will apply.'),
curr_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='The three character currency code according to ISO 4217.'),
plan_gross_sales_price NUMERIC(18,5)
OPTIONS(description='The planned gross sales_1 price of the item_1 in the currency indicated by the currency code.'),
std_gross_sales_price NUMERIC(18,5)
OPTIONS(description='The standard gross sales_1 price of the item_1 in the currency indicated by the currency code'),
price_comment_txt STRING(1000) COLLATE 'und:ci' OPTIONS(description='A free text comment for the planned price change.'),
store_placement_dt DATE
OPTIONS(description='The (planned) date when the item_1 will be put on a certain location_1 within the store.'),
store_placement_loc_cd STRING(30) COLLATE 'und:ci'
OPTIONS(description='A code for the location_1 in a store where items can be placed, e.g. "Gondelkopf", in the freezer or next to the cash register.'),
adv_dt DATE OPTIONS(description='The (planned) date when the advertisement is placed.'),
adv_channel_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) of the advertisement channel.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (campaign_elem_plan_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='In order to accomplish the sales_1 goals of a campaign element, certain marketing activities get planned. This is the supertype for all these planned activities.');