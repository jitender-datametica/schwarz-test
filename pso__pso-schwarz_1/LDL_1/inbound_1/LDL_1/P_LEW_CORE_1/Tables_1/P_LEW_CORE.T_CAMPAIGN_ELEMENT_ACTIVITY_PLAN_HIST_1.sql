/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_activity_plan_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   campaign_elem_plan_sid              NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for an activity that is planned within a certain campaign element.',
   campaign_elem_sid                   NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for the campaign element.',
   campaign_activity_type_cd           VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'The discriminator code for campaign activities.',
   plan_status_cd                      VARCHAR(6)       NOT NULL COLLATE 'en-ci' COMMENT 'A code uniquely identifying the status_1 of a planned campaign activity.',
   price_active_from_dt                DATE             COMMENT 'The begin date of the (planned) price reduction period.',
   price_active_to_dt                  DATE             COMMENT 'The end date of the (planned) price reduction period.',
   sales_channel_sid                   NUMBER(38,0)     COMMENT 'The unique identifier (surrogate key) of the sales_1 channel, for which the price change will apply.',
   curr_cd                             VARCHAR(3)       COLLATE 'en-ci' COMMENT 'The three character currency code according to ISO 4217.',
   plan_gross_sales_price              NUMBER(18,5)     COMMENT 'The planned gross sales_1 price of the item_1 in the currency indicated by the currency code.',
   std_gross_sales_price               NUMBER(18,5)     COMMENT 'The standard gross sales_1 price of the item_1 in the currency indicated by the currency code',
   price_comment_txt                   VARCHAR(1000)    COLLATE 'en-ci' COMMENT 'A free text comment for the planned price change.',
   store_placement_dt                  DATE             COMMENT 'The (planned) date when the item_1 will be put on a certain location_1 within the store.',
   store_placement_loc_cd              VARCHAR(30)      COLLATE 'en-ci' COMMENT 'A code for the location_1 in a store where items can be placed, e.g. "Gondelkopf", in the freezer or next to the cash register.',
   adv_dt                              DATE             COMMENT 'The (planned) date when the advertisement is placed.',
   adv_channel_sid                     NUMBER(38,0)     COMMENT 'The unique identifier (surrogate key) of the advertisement channel.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CAMPAIGN_ELEMENT_ACTIVITY_PLAN_HIST PRIMARY KEY (campaign_elem_plan_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'In order to accomplish the sales_1 goals of a campaign element, certain marketing activities get planned. This is the supertype for all these planned activities.';

