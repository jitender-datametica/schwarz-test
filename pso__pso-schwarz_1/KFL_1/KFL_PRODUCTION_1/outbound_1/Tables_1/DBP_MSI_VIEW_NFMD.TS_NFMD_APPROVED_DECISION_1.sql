--==============================================================
-- Table: ts_nfmd_approved_decision_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_approved_decision_1
   generated from Powerdesigner on Donnerstag, 24. März 2022 15:23:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Unique identifier of the NFMD campaign'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
kjwo_ww BIGNUMERIC(38,0) OPTIONS(description='Calendar_1 year-week when the promotion campaign started. Format JJJJWW'),
dwh_created_tmsp DATETIME OPTIONS(description='timestamp when the record was created'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record'),
markdown_decision_id BIGNUMERIC(38,0) OPTIONS(description='Utilization decision ID - maintained via the frontend'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktion_id, art_id) NOT ENFORCED
)
OPTIONS(description='The release price reduction decision is set for each combination of Article and PromotionCampaign in this table - populated by Frontend');