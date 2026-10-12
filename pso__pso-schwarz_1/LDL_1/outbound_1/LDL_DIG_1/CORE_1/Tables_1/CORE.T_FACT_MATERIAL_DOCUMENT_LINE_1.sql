/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_MATERIAL_DOCUMENT_LINE_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 27. Februar 2024 10:38:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_material_document_line_1 (
material_doc_nr STRING(10) NOT NULL OPTIONS(description='Document number of warehouse movements'),
material_doc_year BIGNUMERIC NOT NULL OPTIONS(description='Year of a material warehouse movement document'),
material_doc_pos_nr STRING(20) NOT NULL OPTIONS(description='The item_1 number of the document material'),
wh_sid BIGNUMERIC OPTIONS(description='Code of warehouse for the physical location_1 for material movements'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the warehouses which receives the deliveries'),
pack_material_nr STRING(20) OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
prod_variant_sid BIGNUMERIC OPTIONS(description='Product Number of a material movement document item_1'),
storage_loc_cd STRING(10) OPTIONS(description='Storage Location_1 of inbound/outbound movement'),
booking_dt DATE
OPTIONS(description='Movement document date: date of goods issue or goods receipt registration in ERP System'),
batch_nr STRING(20)
OPTIONS(description='The batch number per each product and movement ( TEST01, TEST08 ). Column is obsolete and should be removed as it is already replaced by prod_condition_cd'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
prod_gross_loc_val BIGNUMERIC(38,5)
OPTIONS(description='Value in local currency (gross) of material movement on position level of warehouse movement document which will be added or removed to/from the current value of the corresponding material stock. Value of total quantity of corresponding position. This column has an incorrect name and will be replaced by prod_net_local_val.'),
prod_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Value in local currency (net) of material movement on position level of warehouse movement document which will be added or removed to/from the current value of the corresponding material stock. Value of total quantity of corresponding position.	'),
prod_qty BIGNUMERIC(38,0) OPTIONS(description='Quantity of products in unit_1 measure (e.g. 1 unit_1 of product)'),
uom_sid BIGNUMERIC
OPTIONS(description='A surrogate key for the unit_1 of measure - Unit_1 of quantity in "inventory unit_1".'),
entry_prod_qty BIGNUMERIC(38,0) OPTIONS(description='Quantity of products in unit_1 of entry'),
entry_uom_sid BIGNUMERIC
OPTIONS(description='A surrogate key for the unit_1 of entry measure - Unit_1 of quantity in "input" unit. The unit_1 depends on application that create the document (purchase order, sales_1 shipment, inventory etc. and of user behaviour).'),
material_doc_stock_type_cd STRING(20)
OPTIONS(description='A code for type of stock used in material documents (3, F, S, etc..)'),
material_doc_mov_type_cd STRING(20)
OPTIONS(description='Code of product movement in warehouse on position level of warehouse-movement-document (per product_variant, storage and booking date)             For Example: 101 - Goods receipt (WE Wareneingang), 601 - Goods issue/goods delivery (WL WarenausLieferung), 451 - Goods issue returns (WA Retouren)'),
material_doc_special_stock_type_cd STRING(20)
OPTIONS(description='A code for type of special stock such as Customer Stock, Project Stock, Stock in Transit '),
material_doc_mov_reason_cd STRING(20)
OPTIONS(description='A code for the  reason for the goods movement - The Movement Indicator is containing single letter codes to identify the reason for the goods movement such as goods movement w/o reference, goods movement for purchase order, goods movement for production order etc.'),
material_doc_mov_cause_cd BIGNUMERIC
OPTIONS(description='A code to identify what causes the movement of the material in/out or within a warehouse.'),
material_doc_consum_type_cd STRING(20)
OPTIONS(description='A code to identify if the goods movement is a consumtion, no consumtion, asset, sales_1 order etc.'),
material_doc_receipt_type_cd STRING(20)
OPTIONS(description='A code to identify if the warehouse movement is a normal receipt, stock transport order or Tied empties.'),
material_doc_debit_credit_cd STRING(20) OPTIONS(description='A code for material goods debit credit indicator'),
material_doc_mov_process_type_name STRING(50)
OPTIONS(description='Indicator of the process for which the material document has been created. Examples can be Verwertung (Recycling) or Verschrottung (Scrapping).'),
material_doc_mov_process_subtype_name STRING(200)
OPTIONS(description='Detailed explanation of the process for which the material document has been created. Example can be Recycling of old stock through Powerseller / Recycling through Greencycling'),
prod_revenue_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Value amount of the revenue generated by the material document line for the considered process. For example, when we recycle a product we reclaim part of its original value as revenue'),
prod_loss_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Value amount of the loss generated by the material document line for the considered process.'),
delivery_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
delivery_order_pos_nr BIGNUMERIC
OPTIONS(description='The position order number from the system that processes deliveries'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
supplier_order_nr STRING(20) OPTIONS(description='Supplier_1 Order Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC OPTIONS(description='Product position number on purchase order'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in an order'),
delivery_src_type_cd STRING(5)
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
prod_variant_nr STRING(20) OPTIONS(description='The product variant number'),
uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure - Unit_1 of quantity in "inventory unit_1".'),
entry_uom_cd STRING(5)
OPTIONS(description='A code for the unit_1 of entry measure - Unit_1 of quantity in "input" unit. The unit_1 depends on application that create the document (purchase order, sales_1 shipment, inventory etc. and of user behaviour).'),
ref_doc_nr STRING(20) OPTIONS(description='A reference number for linking a material document with a billing document'),
ref_doc_pos_nr STRING(20)
OPTIONS(description='A reference number for linking a material document position with a billing document position'),
prod_condition_cd STRING(20)
OPTIONS(description='The condition code of the product. (01 - can be sold online, 02 - needs to be checked, 03 - for scrapping)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (material_doc_nr, material_doc_year, material_doc_pos_nr) NOT ENFORCED
)
OPTIONS(description='The table contains details for "material documents" - documents which describe movements of goods in, out or inside a warehouse             These movements are created based on a Goods Movement Order/Delivery Order (in SAP terms Delivery Document)             Several material documen can be created for one Delivery Order, and depending if this is an order associated with supplier_1 (purchase for example) or a customer(sale for example)  the corresponding references are filled ( supplier_order_nr, cust_order_sid). For other types of Delivery Orders both fields could be empty.                          Main src - SAP ERP - table MSEG (in SAP terms "material document items")             ');