/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_sales_plan_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAMPAIGN_ELEMENT_SALES_PLAN_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   campaign_elem_plan_sid              NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a sales_1 plan that is defined for a certain campaign element.',
   campaign_elem_sid                   NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for the campaign element.',
   sales_channel_sid                   NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) of the sales_1 channel.',
   sales_period_from_dt                DATE             NOT NULL COMMENT 'The begin date of the period in which the sales_1 quantity is expected to be sold.',
   sales_period_to_dt                  DATE             NOT NULL COMMENT 'The end date of the period in which the sales_1 quantity is expected to be sold.',
   plan_status_cd                      VARCHAR(6)       NOT NULL COLLATE 'en-ci' COMMENT 'A code uniquely identifying the status_1 of the sales_1 plan.',
   plan_sales_pct                      NUMBER(9,5)      NOT NULL COMMENT 'percentage of total quantity that is planned to be sold during this period',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CAMPAIGN_ELEMENT_SALES_PLAN_HIST PRIMARY KEY (campaign_elem_plan_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'Related to a campaign element there are certain sales_1 goals that define how much is sold of the item_1 during the campaign (split by sales_1 channel).';

