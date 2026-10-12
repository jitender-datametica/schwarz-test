/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_AGG_PRODUCT_VARIANT_SALES_DAILY
   GENERATED FROM POWERDESIGNER ON Donnerstag, 15. August 2024 08:13:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_AGG_PRODUCT_VARIANT_SALES_DAILY (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country and is run by an Lidl Digital Country',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31).',
   PROD_VARIANT_SID                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
   IS_PART_OF_BUNDLE_HEADER_CNT_FG     BOOLEAN         NOT NULL COMMENT 'Reporting relevant - if report uses the bundle header count use this flag. Set as ''true'' for bundle header and non-bundle item and ''false'' for bundle position item ',
   IS_PART_OF_BUNDLE_POS_CNT_FG        BOOLEAN         NOT NULL COMMENT 'Reporting relevant - if report uses the bundle header count use this flag. Set as ''true'' for bundle position and non-bundle item and ''false'' for bundle header item ',
   PROD_VARIANT_NR                     VARCHAR(20)     COMMENT 'The product variant number (Variantenartikelnummer)
            ',
   PROD_VARIANT_NAME                   VARCHAR(100)    COMMENT 'The global product variant name (Variantenartikel)',
   PROD_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the product
            ',
   PROD_NR                             VARCHAR(20)     COMMENT 'The number for internal onlineshop product, which is country independent (Kopfartikelnummer)',
   PROD_NAME                           VARCHAR(100)    COMMENT 'The central name defined for a product by German onlineshop (Kopfartikelbezeichnung)',
   BRAND_CLASS_CD                      VARCHAR(5)      COMMENT 'The code for the indicating if product is classified as a Lidl own brand or not',
   BRAND_CLASS_DESCR                   VARCHAR(250)    COMMENT 'A textual description for the product brand type in group language (German) (Marke/Eigenmarke)
            A textual description for the product brand type in group language (German) (Marke/Eigenmarke)',
   DELIVERY_SRC_TYPE_CD                VARCHAR(5)      COMMENT 'The code for source location of product from where it is delivered i.e. from supplier or warehouse directly',
   DELIVERY_SRC_TYPE_DESCR             VARCHAR(250)    COMMENT 'The description for source location of product from where it is delivered i.e. from supplier or warehouse directly (Lager/Strecke)',
   PROD_ORG_LVL_NAME                   VARCHAR(50)     COMMENT 'The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization (Organisationsebene)',
   PROD_QTY                            NUMBER(38, 5)   COMMENT 'Quantity of a particular product ordered (Bestellmenge)',
   PROD_PRICE_NET_EUR_VAL              NUMBER(38, 5)   COMMENT 'Original (listed) net price of the ordered product in euro (includes returns and cancellations) (Bestellumsatz)',
   COGS_PRICE_NET_EUR_VAL              NUMBER(38, 5)   COMMENT 'Cost-of-Goods-sold in euro net (Wareneinsatz)',
   RETURN_PROD_ORDER_DT_PRICE_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'Original (listed) net euro price of all items that were ordered on this date and later returned (Retourenwert (auftragsbezogen))',
   RETURN_PROD_ORDER_DT_QTY            NUMBER(38, 5)   COMMENT 'Quantity of all items that were ordered on this date and later returned (Retourenmenge (auftragsbezogen))',
   RETURN_PROD_PRICE_NET_EUR_VAL       NUMBER(38, 5)   COMMENT 'Original (listed) net euro price of all items that were ordered before and returned on this date (Retourenwert (physisch))',
   RETURN_PROD_QTY                     NUMBER(38, 5)   COMMENT 'Quantity of all items that were ordered before and returned on this date',
   CANCEL_PROD_QTY                     NUMBER(38, 5)   COMMENT 'Quantity of all items that were ordered on this date and then cancelled',
   CANCEL_PROD_PRICE_NET_EUR_VAL       NUMBER(38, 5)   COMMENT 'Original (listed) net euro price of all items that were ordered on this date and then cancelled (Stornowert)',
   CANCEL_COGS_PRICE_NET_EUR_VAL       NUMBER(38, 5)   COMMENT 'Cost-of-Goods-sold in euro net for all items that were ordered on this date and then cancelled (Storno Wareneinsatz)',
   PROD_COUPON_NET_EUR_VAL             NUMBER(38, 5)   COMMENT 'The net euro discount value for the (original/listed) product (cancelled orders are left out of the calculation)',
   DELIVERY_PAUSHAL_NET_EUR_VAL        NUMBER(38, 5)   COMMENT 'A net euro paushal for delivery costs (Versandkostenpauschale) (cancelled orders are left out of the calculation)',
   DELIVERY_PAUSHAL_COUPON_NET_EUR_VAL NUMBER(38, 5)   COMMENT 'A net euro discount value for paushal delivery cost split per every order position (cancelled orders are left out of the calculation)',
   DELIVERY_COST_NET_EUR_VAL           NUMBER(38, 5)   COMMENT 'Article specific net delivery cost in euro. This cost is optional and mostly article dependent. An example is a fridge which has additional delivery costs (Versandkosten) (cancelled orders are left out of the calculation)',
   PROD_SALE_TYPE_CD                   VARCHAR(5)      COMMENT 'This code shows if the product is sold as a single item (SI), group article header (GH) - also referred to as "bundle header", or as a group article component (GC) - also referred to as "bundle component"',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_AGG_PRODUCT_VARIANT_SALES_DAILY PRIMARY KEY (WSHOP_CD, CAL_DT, PROD_VARIANT_SID, IS_PART_OF_BUNDLE_HEADER_CNT_FG, IS_PART_OF_BUNDLE_POS_CNT_FG) NOT ENFORCED 
)  COMMENT = 'A fact table that aggregates sales information at the level of product variant, calendar day and webshop.';
