/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_plan_to_store_group_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CAMPAIGN_ELEMENT_PLAN_TO_STORE_GROUP_HIST_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   campaign_elem_plan_sid              NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for a plan (sales_2 or activity plan) that is defined for a certain campaign element.',
   campaign_store_grp_sid              NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) for the store group.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CAMPAIGN_ELEMENT_PLAN_TO_STORE_GROUP_HIST PRIMARY KEY (campaign_elem_plan_sid, campaign_store_grp_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'relates campaign element (sales_2 or activity) plans to store groups, i.e. defines which campaign element plans are planned for which store group(s).';

