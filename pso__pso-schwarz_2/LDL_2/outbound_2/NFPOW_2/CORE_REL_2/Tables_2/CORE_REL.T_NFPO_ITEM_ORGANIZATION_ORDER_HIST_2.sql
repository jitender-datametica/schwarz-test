CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_organization_order_hist_2 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FK Item_2 master;            CBX: Item.@refNo;            ESB: cbxItem.documentRef;'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key internal organisation, here the organisation the order is related to            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
nfpo_order_version_nr BIGNUMERIC(38,0)
OPTIONS(description='CBX order version;            CBX: LdlItemQuantity.revision;            ESB: cbxItem.itemQuantity.version;'),
nfpo_item_org_order_adv_cal_week BIGNUMERIC(38,0)
OPTIONS(description='FK Calendar_2 Week (advertising week);            CBX: LdlItemQuantity.ldlCtryAdvertisementDate;            ESB: 20 || cbxItem.itemQuantity.countryAdvertise.year || cbxItem.itemQuantity.countryAdvertise.week;'),
nfpo_item_org_order_import_cal_week BIGNUMERIC(38,0)
OPTIONS(description='FK Calendar_2 Week (import to market (OWIM));            CBX: LdlItemQuantity.ldlDeliveryDateOWIM;            ESB: 20 || cbxItem.itemQuantity.countryImport.year || cbxItem.itemQuantity.countryImport.week;'),
nfpo_item_org_order_sell_from_dt DATE
OPTIONS(description='Item_2 on sale from date;            CBX: LdlItemQuantity.ldlCtrySalesDate;            ESB: cbxItem.itemQuantity.countrySaleDate;'),
nfpo_item_org_order_carton_kg_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='Carton weight in kg;            CBX: LdlItemQuantity.ldlCtyBruttoKolli;            ESB: cbxItem.itemQuantity.countryBruttoKolli;'),
nfpo_total_item_org_order_qty BIGNUMERIC(38,5)
OPTIONS(description='Order Quantity in Retail SKU;            CBX: LdlItemQuantity.ldlTotalQtyPerCountry;            ESB: cbxItem.itemQuantity.countyOrderQuantityUnit;'),
nfpo_total_item_org_order_case_qty BIGNUMERIC(38,5)
OPTIONS(description='Order Quantity in Carton SKU;            CBX: LdlItemQuantity.ldlTotalNumOfCtn;            ESB: cbxItem.itemQuantity.countryOrderQuantityCarton;'),
nfpo_item_org_order_note_txt STRING(1000)
OPTIONS(description='Order notes;            CBX: LdlItemQuantity.ldlArticleInformation;            ESB: cbxItem.itemQuanity.articleInformation;'),
ldl_planned_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of stores intended to sell the item_2 (Lidl)            AMP: Filialanzahl            '),
kfl_planned_large_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of large stores intended to sell the item_2 (Kaufland)            STEP:MARKTANZAHL_GROSS'),
kfl_planned_small_store_cnt BIGNUMERIC(38,0)
OPTIONS(description='number of small stores intended to sell the item_2 (Kaufland)            STEP:MARKTANZAHL_KLEIN'),
nfpo_item_org_order_purch_net_euro_price BIGNUMERIC(38,5)
OPTIONS(description='purchasing net price in EURO (Warenbezugspreis)            CBX:Item_2/ldlItemQuantity/LdlItemQuantity[n]/ldlCtryBuyingPriceCrypt            ESB:cbxItem/itemQuantity/countryBuyingPriceCrypt'),
nfpo_item_org_order_sales_vat_pct BIGNUMERIC(38,5)
OPTIONS(description='vat percentage            AMP: tax_value             STEP: steuersatz_nonfood'),
nfpo_item_org_order_sales_gross_euro_price BIGNUMERIC(38,5)
OPTIONS(description='sales_2 gross price in EURO (VK_2 brutto in EUR)            AMP: VK_2 in EUR brutto            STEP: VK_2 in EUR brutto'),
local_eks_sup_nr STRING(100)
OPTIONS(description='supplier_2 number used in EKS for the local subsidiary of the supplier_2            CBX: LDL_ITEM_QUANTITY.LDL_EKS_NO            '),
local_sup_name STRING(100)
OPTIONS(description='name of the local subsidiary of the supplier_2            CBX: LDL_ITEM_QUANTITY.LDL_VENDOR_NAME            '),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_2 angenommen.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='order information of NFPO items for the local NFPO\'s             CBX: LDL_ITEM_QUANTITY_2             LDL DWH: t_mdm_item_client_order_2, t_mdm_item_client_order_hist_2');