CREATE TABLE CORE_REL.T_NFPO_ITEM_ORGANIZATION_ORDER_DELIVERY_HIST_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'FK Item_2 master;
            CBX: Item.@refNo;
            ESB: cbxItem.documentRef;',
   nfpo_org_sid                        NUMBER(38,0)     NOT NULL COMMENT 'surrogate key internal organisation, here the organisation the order is related to
            CBX: LDL_ITEM_QUANTITY.LDL_COUNTRY_CODE',
   nfpo_item_org_order_deliv_seq       NUMBER(38,0)     NOT NULL COMMENT 'Delivery number;
            CBX: LdlItemQuantity.ldlDeilveryWeekX;
            ESB: cbxItem.itemQuantity.deliver.deliveryNumber;',
   nfpo_item_org_order_deliv_cal_week  NUMBER(38,0)     COMMENT 'FK Calendar_2 Week (delivery week);
            CBX: LdlItemQuantity.ldlDeliveryWeekX;
            ESB: 20 || cbxItem.itemQuantity.delivery.delivery.year || cbxItem.itemQuantity.delivery.delivery.week;',
   nfpo_planned_item_org_order_deliv_qty NUMBER(38,5)     COMMENT 'Requested unit_2 quantity;
            CBX: LdlItemQuantity.ldlPlanQtyX;
            ESB: cbxItem.itemQuantity.delivery.planQuantity;',
   nfpo_item_org_order_deliv_qty       NUMBER(38,5)     COMMENT 'Scheduled unit_2 quantity;
            CBX: LdlItemQuantity.ldlTotalQtyX;
            ESB: cbxItem.itemQuantity.delivery.totalQuantity;',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'Datensatz ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt (CBX, Centric, etc.); Hinweis: auch bei gesetztem loesch_kz im Quellsystem wird dieser Status_2 angenommen.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsbeginn; Teil der DWH-Historisierung; ältester Satz der Historie erhält immer den Wert 01.01.1900 ("minus unendlich").',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Gültigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhält immer den Wert 30.12.9999 ("plus unendlich").',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_ORGANIZATION_ORDER_DELIVERY_HIST PRIMARY KEY (nfpo_item_sid, nfpo_org_sid, nfpo_item_org_order_deliv_seq, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'order information of NFPO items for the local NFPO''s split into planned delivery waves
             CBX: LDL_ITEM_QUANTITY_2
             LDL DWH: t_mdm_item_client_order_delivery_hist_2';
