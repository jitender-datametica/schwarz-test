--==============================================================
-- Table: ts_nfmd_article_price_date
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_article_price_date
   generated from Powerdesigner on Montag, 3. Februar 2025 14:10:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_DATE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   discount_type_name                  VARCHAR(50)      NOT NULL DEFAULT 'nfmd' COMMENT 'Describes the discount type for this article in the given store and promotion campaing. "nfmd" - is the defatult, initial discount. "second_discount" means the price of the product has been reduced for a second time in the same promotion.',
   kjwo_ww                             NUMBER(38,0)     NOT NULL COMMENT 'Calendar year-week when the promotion campaign started. Format JJJJWW',
   manual_promo_price_dt               VARCHAR(255)     COMMENT 'date when the new price becomes effective - maintained via the frontend (can we change to type DATE. Is MSTR fine to write this type)',
   user_id                             VARCHAR(255)     COMMENT 'AD name of the user who created the record',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'timestamp when the record was created',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_ARTICLE_PRICE_DATE PRIMARY KEY (mandant_id, aktion_id, art_id, discount_type_name) NOT ENFORCED
)  COMMENT = 'In this table, the effective date of manual price changes is written at the article level.';
