/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_EXCISE_ANALYSIS_PER_DAY_2
   generated from Powerdesigner on Dienstag, 10. Oktober 2023 12:48:08
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_EXCISE_ANALYSIS_PER_DAY_2 (
   TRADER_REFERENCE_NR                 VARCHAR(250)    NOT NULL COMMENT 'This is a reference assigned by the declarant for the goods covered by the declaration.',
   CUSTOMS_PRODUCT_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the customs product.',
   AUTHORITY_COUNTRY_LOCATION_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   REPORT_DT                           DATE            NOT NULL COMMENT 'This is the date when the goods have arrived at the import location_2 (from Broker Report) or the goods was ordered (from Consignor)..',
   BROKER_DECLARANT_PARTY_SID          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the broker declarant.',
   CONSIGNOR_PARTY_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the consignor as defined in the consignor reports (BEI/WWT).',
   BROKER_CONSIGNOR_PARTY_SID          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the consignor as defined in the broker report.',
   CDS_CONSIGNOR_PARTY_SID             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the consignor as defined in the CDS report.',
   ORIGINAL_CONSIGNOR_PARTY_SID        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the original consignor in BEI or WWT report.',
   CUSTOMS_DECLARATION_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of the customs declaration',
   CUSTOMS_PREFERENCE_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs preference.',
   CURR_CD                             VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'The code identifying the currency according to ISO-4217.',
   MOVEMENT_REF_NUMBER_TXT             VARCHAR(1000)   NOT NULL COMMENT 'Descriptive Attribute - Comma separated list of all movement reference numbers for this trader reference.',
   ITEM_POSITION_TXT                   VARCHAR(1000)   NOT NULL COMMENT 'Descriptive Attribute - Comma separated list of the item_2 position numbers in the broker report for the trader reference and customs product.',
   ARTICLE_VARIANT_NR_TXT              VARCHAR(1000)   COMMENT 'Descriptive Attribute - The article variant number for a GTS product.',
   BROKER_LINE_CNT                     NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines in the broker report.',
   BROKER_LINE_MISSING_CNT             NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines that are missed in the broker report, because there was no match found for the corresponding conisgnor report lines..',
   CONSIGNOR_LINE_CNT                  NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines in the consignor report.',
   CONSIGNOR_LINE_MISSING_CNT          NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines that are missed in the consignor report, because there was no match found for the corresponding broker report lines..',
   BROKER_TAX_CD                       VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - The alcoholic beverage tax code the broker used to calculate the excise duty.',
   CONSIGNOR_TAX_CD                    VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - The alcoholic beverage tax code the consignor used to calculate the excise duty.',
   DIFFERENT_TAX_CODE_CNT              NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines where the tax code is different between the consignor and broker report.',
   BROKER_EXCISE_QTY                   NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The quantity (in liter or liter of pure alcohol depending on the alcoholic beverage type) declared by the broker.',
   CONSIGNOR_EXCISE_QTY                NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The quantity (in liter or liter of pure alcohol depending on the alcoholic beverage type) calculated by the consignor.',
   DIFFERENT_EXCISE_QUANTITY_CNT       NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines where the calculated quantity of the consignor is different to the declared quantity of the broker.',
   BROKER_EXCISE_VAL                   NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The amount of excise duty declared by the broker and paid by the consignor.',
   CONSIGNOR_EXCISE_VAL                NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The amount of excise duty calculated by the consignor.',
   OVERPAID_EXCISE_VAL                 NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The amount of overpaid excise duty as the positive difference between the paid excise duty and the calculated excise duty ',
   UNDERPAID_EXCISE_VAL                NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The amount of underpaid excise duty as the negative difference between the paid excise duty and the calculated excise duty ',
   DIFFERENT_EXCISE_AMOUNT_CNT         NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines where the calculated excise duty of the consignor is different to the declared excise duty of the broker.',
   CORRECT_EXCISE_AMOUNT_CNT           NUMBER(38, 0)   NOT NULL COMMENT 'Fact - additive - The count of lines where the calculated excise duty of the consignor is equal to the declared excise duty of the broker.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_FACT_EXCISE_ANALYSIS_PER_DAY PRIMARY KEY (TRADER_REFERENCE_NR, CUSTOMS_PRODUCT_SID, AUTHORITY_COUNTRY_LOCATION_SID, REPORT_DT, BROKER_DECLARANT_PARTY_SID, CUSTOMS_DECLARATION_TYPE_CD, CUSTOMS_PREFERENCE_CD, CONSIGNOR_PARTY_SID, BROKER_CONSIGNOR_PARTY_SID, CDS_CONSIGNOR_PARTY_SID, ORIGINAL_CONSIGNOR_PARTY_SID, CURR_CD) NOT ENFORCED 
)  COMMENT = 'Fact table - Analytical - Granularity - by day and trader reference and customs product - Aggregate - Contains facts to compare the Broker Report with the Consignor Report to determine differences in the paid excises on a level of trader references. - Source - Broker Report, GTS/WWT';
