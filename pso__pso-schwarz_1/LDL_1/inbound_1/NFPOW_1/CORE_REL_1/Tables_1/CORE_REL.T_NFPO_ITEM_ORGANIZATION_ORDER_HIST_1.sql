CREATE TABLE CORE_REL.T_NFPO_ITEM_ORGANIZATION_ORDER_HIST_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'FK Item_1 master;
            CBX: Item.@refNo;
            ESB: cbxItem.documentRef;',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key internal organisation, here the organisation the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   nfpo_order_version_nr               NUMBER(38,0)     COMMENT 'CBX order version;
            CBX: LdlItemQuantity.revision;
            ESB: cbxItem.itemQuantity.version;',
   nfpo_item_org_order_adv_cal_week    NUMBER(38,0)     COMMENT 'FK Calendar_1 Week (advertising week);
            CBX: LdlItemQuantity.ldlCtryAdvertisementDate;
            ESB: 20 || cbxItem.itemQuantity.countryAdvertise.year || cbxItem.itemQuantity.countryAdvertise.week;',
   nfpo_item_org_order_import_cal_week NUMBER(38,0)     COMMENT 'FK Calendar_1 Week (import to market (OWIM));
            CBX: LdlItemQuantity.ldlDeliveryDateOWIM;
            ESB: 20 || cbxItem.itemQuantity.countryImport.year || cbxItem.itemQuantity.countryImport.week;',
   nfpo_item_org_order_sell_from_dt    DATE             COMMENT 'Item_1 on sale from date;
            CBX: LdlItemQuantity.ldlCtrySalesDate;
            ESB: cbxItem.itemQuantity.countrySaleDate;',
   nfpo_item_org_order_carton_kg_weight_meas NUMBER(38,5)     COMMENT 'Carton weight in kg;
            CBX: LdlItemQuantity.ldlCtyBruttoKolli;
            ESB: cbxItem.itemQuantity.countryBruttoKolli;',
   nfpo_total_item_org_order_qty       NUMBER(38,5)     COMMENT 'Order Quantity in Retail SKU;
            CBX: LdlItemQuantity.ldlTotalQtyPerCountry;
            ESB: cbxItem.itemQuantity.countyOrderQuantityUnit;',
   nfpo_total_item_org_order_case_qty  NUMBER(38,5)     COMMENT 'Order Quantity in Carton SKU;
            CBX: LdlItemQuantity.ldlTotalNumOfCtn;
            ESB: cbxItem.itemQuantity.countryOrderQuantityCarton;',
   nfpo_item_org_order_note_txt        VARCHAR(1000)    COMMENT 'Order notes;
            CBX: LdlItemQuantity.ldlArticleInformation;
            ESB: cbxItem.itemQuanity.articleInformation;',
   ldl_planned_store_cnt               NUMBER(38,0)     COMMENT 'number of stores intended to sell the item_1 (Lidl)
            AMP: Filialanzahl
            ',
   kfl_planned_large_store_cnt         NUMBER(38,0)     COMMENT 'number of large stores intended to sell the item_1 (Kaufland)
            STEP:MARKTANZAHL_GROSS',
   kfl_planned_small_store_cnt         NUMBER(38,0)     COMMENT 'number of small stores intended to sell the item_1 (Kaufland)
            STEP:MARKTANZAHL_KLEIN',
   nfpo_item_org_order_purch_net_euro_price NUMBER(38,5)     COMMENT 'purchasing net price in EURO (Warenbezugspreis)
            CBX:Item_1/ldlItemQuantity/LdlItemQuantity[n]/ldlCtryBuyingPriceCrypt
            ESB:cbxItem/itemQuantity/countryBuyingPriceCrypt',
   nfpo_item_org_order_sales_vat_pct   NUMBER(38,5)     COMMENT 'vat percentage
            AMP: tax_value 
            STEP: steuersatz_nonfood',
   nfpo_item_org_order_sales_gross_euro_price NUMBER(38,5)     COMMENT 'sales_1 gross price in EURO (VK_1 brutto in EUR)
            AMP: VK_1 in EUR brutto
            STEP: VK_1 in EUR brutto',
   local_eks_sup_nr                    VARCHAR(100)     COMMENT 'supplier_1 number used in EKS for the local subsidiary of the supplier_1
            CBX: LDL_ITEM_QUANTITY.LDL_EKS_NO
            ',
   local_sup_name                      VARCHAR(100)     COMMENT 'name of the local subsidiary of the supplier_1
            CBX: LDL_ITEM_QUANTITY.LDL_VENDOR_NAME
            ',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_1 angenommen.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_ORGANIZATION_ORDER_HIST PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'order information of NFPO items for the local NFPO''s
             CBX: LDL_ITEM_QUANTITY_1
             LDL DWH: t_mdm_item_client_order_1, t_mdm_item_client_order_hist_1';