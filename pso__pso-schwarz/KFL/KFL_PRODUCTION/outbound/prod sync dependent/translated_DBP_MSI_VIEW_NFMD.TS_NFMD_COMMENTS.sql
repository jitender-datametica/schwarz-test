CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_nfmd.ts_nfmd_comments (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Unique identifier of the NFMD campaign'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
kjwo_ww INTEGER OPTIONS(description='Calendar year-week when the promotion campaign started. Format JJJJWW'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record'),
comment_txt STRING(255) OPTIONS(description='text of the comment'),
dwh_created_tmsp DATETIME OPTIONS(description='timestamp_ntz(9) when the record was created'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktion_id, art_id) NOT ENFORCED
)
OPTIONS(description='The comments on  the utilization decision are stored in this table (per combination of  Article  and  PromotionCampaign) .\n             The comments can be created both in the first step of the exploitation decision and in the second step of the Markdown decision.');