CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_organization_order_delivery_hist_1 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FK Item_1 master;            CBX: Item.@refNo;            ESB: cbxItem.documentRef;'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key internal organisation, here the organisation the order is related to            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE'),
nfpo_item_org_order_deliv_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Delivery number;            CBX: LdlItemQuantity.ldlDeilveryWeekX;            ESB: cbxItem.itemQuantity.deliver.deliveryNumber;'),
nfpo_item_org_order_deliv_cal_week BIGNUMERIC(38,0)
OPTIONS(description='FK Calendar_1 Week (delivery week);            CBX: LdlItemQuantity.ldlDeliveryWeekX;            ESB: 20 || cbxItem.itemQuantity.delivery.delivery.year || cbxItem.itemQuantity.delivery.delivery.week;'),
nfpo_planned_item_org_order_deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='Requested unit_1 quantity;            CBX: LdlItemQuantity.ldlPlanQtyX;            ESB: cbxItem.itemQuantity.delivery.planQuantity;'),
nfpo_item_org_order_deliv_qty BIGNUMERIC(38,5)
OPTIONS(description='Scheduled unit_1 quantity;            CBX: LdlItemQuantity.ldlTotalQtyX;            ESB: cbxItem.itemQuantity.delivery.totalQuantity;'),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_1 angenommen.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, nfpo_item_org_order_deliv_seq, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='order information of NFPO items for the local NFPO\'s split into planned delivery waves             CBX: LDL_ITEM_QUANTITY_1             LDL DWH: t_mdm_item_client_order_delivery_hist_1');