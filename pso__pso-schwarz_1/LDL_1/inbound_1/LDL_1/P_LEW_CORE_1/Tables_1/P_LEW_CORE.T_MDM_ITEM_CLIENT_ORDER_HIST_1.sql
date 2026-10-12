/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_client_order_hist_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 13:34:07
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_CLIENT_ORDER_HIST_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item_1 instance
            CBX: CNT_ITEM.REF_NO',
   client_id_order                     NUMBER(38,0)     NOT NULL COMMENT 'foreign key client (placing order), derived from the identifier of the local NFPO in the NFPO source system
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   int_org_sid                         NUMBER(38,0)     COMMENT 'surrogate key internal organisation, here the organisation the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   cbx_order_version                   NUMBER(38,0)     COMMENT 'technical version of the NFPO item_1 order in the source system
            CBX: LDL_ITEM_QUANTITY.REVISION',
   cy_week_advertise                   NUMBER(38,0)     COMMENT 'planned calendar_1 week of the advertising for this item_1 in the sales_1 area of the local NFPO
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_ADVERTISEMENT_DATE',
   cy_week_import                      NUMBER(38,0)     COMMENT 'planned week of the delivery for this item_1 into the area of the local NFPO
            CBX: LDL_ITEM_QUANTITY.LDL_DELIVERY_DATE_OWIM',
   client_sell_from_dt                 DATE             COMMENT 'planned sales_1 start date in the sales_1 area of the local NFPO
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_SALES_DATE',
   client_order_carton_weight          NUMBER(18,5)     COMMENT 'case weight in kg;
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_BRUTTO_KOLLI',
   client_order_total_qty              NUMBER(38,0)     COMMENT 'total order piece quantity
            CBX: LDL_ITEM_QUANTITY.LDL_TOTAL_QTY_PER_COUNTRY',
   client_order_total_carton_qty       NUMBER(38,0)     COMMENT 'total order case quantity
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_TOTAL_NUM_OF_CTN',
   client_order_notes                  VARCHAR(300)     COLLATE 'en-ci' COMMENT 'Order notes of the local NFPO
            CBX: LDL_ITEM_QUANTITY.LDL_ARTICLE_INFORMATION',
   ldl_store_cnt                       NUMBER(38,0)     COMMENT 'number of stores intended to sell the item_1 (Lidl)
            AMP: Filialanzahl
            ',
   kfl_large_store_cnt                 NUMBER(38,0)     COMMENT 'number of large stores intended to sell the item_1 (Kaufland)
            STEP:MARKTANZAHL_GROSS',
   kfl_small_store_cnt                 NUMBER(38,0)     COMMENT 'number of small stores intended to sell the item_1 (Kaufland)
            STEP:MARKTANZAHL_KLEIN',
   purch_net_euro_price                NUMBER(18,5)     COMMENT 'purchasing net price in EURO (Warenbezugspreis)
            CBX: LDL_ITEM_QUANTITY.LDL_CTRY_BUYING_PRICE_CRYPT',
   sales_vat_pct                       NUMBER(38,5)     COMMENT 'vat percentage
            AMP: tax_value 
            STEP: steuersatz_nonfood',
   sales_gross_euro_price              NUMBER(18,5)     COMMENT 'sales_1 gross price in EURO (VK_1 brutto in EUR)
            AMP: VK_1 in EUR brutto
            STEP: VK_1 in EUR brutto',
   local_eks_sup_nr                    VARCHAR(100)     COMMENT 'supplier_1 number used in EKS for the local subsidiary of the supplier_1
            CBX: LDL_ITEM_QUANTITY.LDL_EKS_NO
            ',
   local_sup_name                      VARCHAR(100)     COMMENT 'name of the local subsidiary of the supplier_1
            CBX: LDL_ITEM_QUANTITY.LDL_VENDOR_NAME
            ',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_CLIENT_ORDER_HIST PRIMARY KEY (mdm_item_sid, client_id_order, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'order information of NFPO items for the local NFPOs
             CBX: LDL_ITEM_QUANTITY_1';
