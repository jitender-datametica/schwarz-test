--==============================================================
-- Table: t_inbound_transport_plan_warehouse_position_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_inbound_transport_plan_warehouse_position_1
   generated from Powerdesigner on Dienstag, 13. August 2024 09:50:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INBOUND_TRANSPORT_PLAN_WAREHOUSE_POSITION_1 (
   inbound_dispo_order_pos_sid         NUMBER          NOT NULL COMMENT 'unique identifier of the order position that is transported',
   logistics_service_site_sid          NUMBER          NOT NULL COMMENT 'unique identifier of the site where the logistic service takes place',
   logistics_service_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistics service, e.g. short-time storage.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   dispo_nr                            VARCHAR(20)     NOT NULL COMMENT 'business identifier of the dispo',
   transport_plan_pos_seq              NUMBER          COMMENT 'indicator for the sequence in which the activities are conducted',
   logistics_company_sid               NUMBER          NOT NULL COMMENT 'unique identifier of the hauler that transports the ordered product from one site to another site',
   plan_start_from_dt                  DATE            COMMENT 'point in time when the product delivery starts earliest',
   plan_start_to_dt                    DATE            COMMENT 'point in time when the products delivery starts latest',
   plan_end_from_dt                    DATE            COMMENT 'point in time when the products need to be at the destination or the service needs to be finished earliest',
   plan_end_to_dt                      DATE            COMMENT 'point in time when the products need to be at the destination or the service needs to be finished latest',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_INBOUND_TRANSPORT_PLAN_WAREHOUSE_POSITION PRIMARY KEY (dwh_valid_from_tmsp, inbound_dispo_order_pos_sid, logistics_service_type_cd, logistics_service_site_sid) NOT ENFORCED 
)  COMMENT = 'The entity contains information regarding transport for all products of a disposition, i.e. which logistics services are conducted during the transportation of a product (e.g. short-time storage).';
