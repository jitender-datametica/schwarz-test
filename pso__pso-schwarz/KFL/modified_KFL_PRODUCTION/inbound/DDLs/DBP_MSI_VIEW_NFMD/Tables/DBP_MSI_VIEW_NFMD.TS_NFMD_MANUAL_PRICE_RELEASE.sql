--==============================================================
-- Table: ts_nfmd_manual_price_release
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_manual_price_release
   generated from Powerdesigner on Dienstag, 4. Februar 2025 11:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Unique identifier of the NFMD campaign.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   wup_id                              INTEGER     COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   discount_type_name                  VARCHAR(50)      COMMENT 'Describes the discount type for this article in the given store and promotion campaing. "nfmd" - is the initial discount. "second_discount" means the price of the product has been reduced for a second time in the same promotion.',
   kjwo_ww                             INTEGER     COMMENT 'Calendar year-week when the promotion campaign started. Format JJJJWW.',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR.',
   manual_promo_price_gross_local_val  NUMBER(29,5)     COMMENT 'New promotion price - maintained via the frontend (brutto/netto .. which currency).',
   model_price_gross_local_val         NUMBER(29,5)     COMMENT 'Price recommended by the model.',
   manual_promo_price_dt               DATE             COMMENT 'Date when the new price becomes effective - maintained via the frontend (can we change to type DATE. Is MSTR fine to write this type).',
   last_transfer_tmsp                  TIMESTAMP_NTZ(9) COMMENT 'Timestamp of the last  export to SAP.',
   user_id                             VARCHAR(255)     COMMENT 'AD name of the user who created the record.',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Timestamp when the record was created.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_MANUAL_PRICE_RELEASE PRIMARY KEY (mandant_id, aktion_id, art_id) NOT ENFORCED
)  COMMENT = 'The release of the changed price and its validity date are written in this table at Article-Market (Store)-Promotion Campaign level.';
