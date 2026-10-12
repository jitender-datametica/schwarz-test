--==============================================================
-- Table: t_dim_inbound_dispo_order_position_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_inbound_dispo_order_position_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:14:27
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_INBOUND_DISPO_ORDER_POSITION_2 (
   inbound_dispo_order_pos_sid         NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the disposition position.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   inbound_dispo_order_sid             NUMBER          COMMENT 'unique identifier of the corresponding dispositon.',
   dispo_nr                            VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the disposition for the business.',
   transport_unit_seq                  NUMBER          COMMENT 'the total quantity that needs to be delivered at the warehouse may be splittet, i.e. each quantity part needs to be transported individually in order to reduce risk of receiving total quantity late',
   order_reference_nr                  VARCHAR(250)    COMMENT '14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)',
   purchase_order_nr                   VARCHAR(20)     COMMENT 'Purchase order number of Wawi',
   version_nr                          NUMBER          COMMENT 'each time a change is done to the order after the order was placed at the supplier_2, the dispo itself receives a new version nr and each order line is marked with this new version number (no matter if this position was actually changed or not)',
   dispo_order_change_reason_cd        VARCHAR(20)     COMMENT 'indicating what kind of information changed in comparison to the previous version (e.g. the order quantity or the delivery date)',
   delivery_from_dt                    DATE            COMMENT 'when does the product need to be delivered at the warehouse earliest',
   delivery_to_dt                      DATE            COMMENT 'when does the product need to be delivered at the warehouse latest',
   receiving_party_sid                 NUMBER          COMMENT 'The unique identifier of the receiving party, e.g. regional subsidiary.',
   delivering_party_sid                NUMBER          COMMENT 'The unique identifier of the delivering party, e.g. the supplier.',
   receiving_site_sid                  NUMBER          COMMENT 'The unique identifier of the receiving site, e.g. central warehouse.',
   delivering_site_sid                 NUMBER          COMMENT 'The unique identifier of the delivery site, e.g. supplier_2 location.',
   double_deck_fg                      BOOLEAN         COMMENT 'indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space',
   pallet_type_cd                      VARCHAR(20)     COMMENT 'A code for the pallet that indicates the storage occupation for transportation.',
   pallet_cnt                          NUMBER          NOT NULL COMMENT 'The total number of pallets that have been ordered.',
   adv_pallet_cnt                      NUMBER          COMMENT 'The total number of pallets that have been ordered as part of an advertising campaign.',
   missing_pallet_cnt                  NUMBER          COMMENT 'The total number of pallets that are missing',
   pallet_case_factor                  NUMBER(38, 5)   COMMENT 'How many logistic units are packed on the pallet?',
   pallet_storage_space_factor         NUMBER(38, 5)   COMMENT 'Hoch much pallet storage space is occupied by one unit_2 of the order quantity, e.g. 1 order quantity unit_2 occupies 0.5 pallet storage space',
   case_size_qty                       NUMBER(38, 5)   COMMENT 'How many sales_2 units are packed in the logistic variant?',
   pallet_storage_space_meas           NUMBER(38, 5)   COMMENT 'Precalculated amount of storage space. (PALLET_CNT * PALLET_STORAGE_SPACE_FACTOR * CASE WHEN DOUBLE_DECK_FG = 1 THEN 0.5 ELSE 1 END)',
   pallet_height_meas                  NUMBER(38, 5)   COMMENT 'which height does one pallet unit_2 have, i.e. height of all packet product cases plus pallet itself',
   pallet_weight_meas                  NUMBER(38, 5)   COMMENT 'which weight does one pallet unit_2 have, i.e. weight of all product cases plus pallet itself',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_INBOUND_DISPO_ORDER_POSITION PRIMARY KEY (inbound_dispo_order_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'The entity contains detailed information about the products for all inbound logistics dispositions.';
