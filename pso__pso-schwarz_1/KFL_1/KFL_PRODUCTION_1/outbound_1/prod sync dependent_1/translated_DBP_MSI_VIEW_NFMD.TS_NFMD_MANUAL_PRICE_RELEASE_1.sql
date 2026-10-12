CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Unique identifier of the NFMD campaign.'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wup_id INTEGER OPTIONS(description='Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
discount_type_name STRING(50)
OPTIONS(description='Describes the discount type for this article in the given store and promotion campaing.\""nfmd\"" - is the initial discount.\""second_discount\"" means the price of the product has been reduced for a second time in the same promotion.'),
kjwo_ww INTEGER OPTIONS(description='Calendar_1 year-week when the promotion campaign started. Format JJJJWW.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR.'),
manual_promo_price_gross_local_val NUMERIC(29,5)
OPTIONS(description='New promotion price - maintained via the frontend (brutto/netto .. which currency).'),
model_price_gross_local_val NUMERIC(29,5) OPTIONS(description='Price recommended by the model.'),
manual_promo_price_dt DATE
OPTIONS(description='Date when the new price becomes effective - maintained via the frontend (can we change to type DATE. Is MSTR fine to write this type).'),
last_transfer_tmsp DATETIME OPTIONS(description='timestamp_ntz(9) of the last  export to SAP.'),
user_id STRING(255) OPTIONS(description='AD name of the user who created the record.'),
dwh_created_tmsp DATETIME OPTIONS(description='timestamp_ntz(9) when the record was created.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, aktion_id, art_id) NOT ENFORCED
)
OPTIONS(description='The release of the changed price and its validity_1 date are written in this table at Article-Market (Store)-Promotion Campaign level.');