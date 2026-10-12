--==============================================================
-- Table: ts_nfmd_article_price_date_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_article_price_date_1
   generated from Powerdesigner on Montag, 3. Februar 2025 14:10:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_nfmd.ts_nfmd_article_price_date_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Unique identifier of the NFMD campaign'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
discount_type_name STRING(50) DEFAULT 'nfmd' NOT NULL
OPTIONS(description='Describes the discount type for this article in the given store and promotion campaing. "nfmd" - is the defatult, initial discount. "second_discount" means the price of the product has been reduced for a second time in the same promotion.'),
kjwo_ww BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Calendar_1 year-week when the promotion campaign started. Format JJJJWW'),
manual_promo_price_dt STRING(255)
OPTIONS(description='date when the new price becomes effective - maintained via the frontend (can we change to type DATE. Is MSTR fine to write this type)'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record'),
dwh_created_tmsp DATETIME OPTIONS(description='timestamp when the record was created'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktion_id, art_id, discount_type_name) NOT ENFORCED
) OPTIONS(description='In this table, the effective date of manual price changes is written at the article level.');