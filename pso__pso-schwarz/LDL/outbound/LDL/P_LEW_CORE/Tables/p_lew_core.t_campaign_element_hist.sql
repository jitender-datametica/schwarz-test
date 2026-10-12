/* --------------------------------------------------------------------------------
   DDL for table: t_campaign_element_hist
   generated from Powerdesigner on Mittwoch, 31. Mai 2023 17:00:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_campaign_element_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
campaign_elem_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the campaign element.'),
campaign_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for a Campaign.'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Item that is targeted by this campaign element.'),
item_selection_nr STRING(20) OPTIONS(description='NFPO source system internal identifier for an article.'),
mdm_item_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key NFPO ITEM INSTANCE.'),
campaign_elem_status_cd STRING(6) COLLATE 'und:ci' NOT NULL
OPTIONS(description='A code uniquely identifying the status of a planned campaign activity (i.e., the plan to execute the activity is still valid, or we have given up this plan).'),
campaign_elem_start_dt DATE
OPTIONS(description='the start date of when a specific campaign element is part of the campaign, e.g. only starting with the second week of the campaign'),
campaign_elem_end_dt DATE
OPTIONS(description='the end date of when a specific campaign element is part of the campaign, e.g. ending with the first week of the 4-week campaign'),
plan_adv_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of the days the campaign element is part of the campaign; might be different from end-start_date, e.g. if it spans a weekend'),
plan_item_qty NUMERIC(18,5)
OPTIONS(description='The number / quantity of items that Lidl plans to sell as part of this campaign element.'),
int_cat_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='free text description for the campaign element category (known by all countries); e.g. "In/Out", "Sonderpreise", ,..'),
nat_cat_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='free text description for the campaign element category as defined by the country'),
nat_theme_txt STRING(1000)
OPTIONS(description='free text for the editor of the campaign in PIT. This is an additional field which can be used instead or sometimes also additionally to the existing ones.'),
comment_txt STRING(1000) COLLATE 'und:ci' OPTIONS(description='free text comment regarding the campaign element'),
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
PRIMARY KEY (campaign_elem_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='A campaign can be broken down into several elements. Each campaign element targets one item and is related to a number of store groups.              E.g. the campaign "Italy" that runs in the first week of February, contains two campaign elements - one that aims to increase the sale of spaghetti in Northern Germany and another one that targets pizza in Southern Germany.             Each campaign element results in a number of marketing activities, such as price reductions or advertisements.');