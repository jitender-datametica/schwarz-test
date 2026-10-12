--==============================================================
-- Table: ts_nfmd_article_price_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_article_price_1
   generated from Powerdesigner on Montag, 3. Februar 2025 14:10:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_ARTICLE_PRICE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Unique identifier of the NFMD campaign',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   discount_type_name                  VARCHAR(50)      NOT NULL DEFAULT 'nfmd' COMMENT 'Describes the discount type for this article in the given store and promotion campaing. "nfmd" - is the defatult, initial discount. "second_discount" means the price of the product has been reduced for a second time in the same promotion.',
   kjwo_ww                             INTEGER     COMMENT 'Calendar_1 year-week when the promotion campaign started. Format JJJJWW',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   manual_promo_price_gross_local_val  NUMBER(29,2)     COMMENT 'new promotion price - maintained via the frontend ',
   user_id                             VARCHAR(255)     COMMENT 'AD name of the user who created the record',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'timestamp when the record was created',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_ARTICLE_PRICE PRIMARY KEY (mandant_id, aktion_id, art_id, discount_type_name) NOT ENFORCED
)  COMMENT = 'The manually set price at Article-PromotionCampaign level is written to this table.';
