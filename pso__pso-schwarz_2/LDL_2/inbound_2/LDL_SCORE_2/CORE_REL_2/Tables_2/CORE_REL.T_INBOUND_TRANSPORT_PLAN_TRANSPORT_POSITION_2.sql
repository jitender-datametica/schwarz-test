--==============================================================
-- Table: t_inbound_transport_plan_transport_position_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_inbound_transport_plan_transport_position_2
   generated from Powerdesigner on Montag, 26. August 2024 08:46:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INBOUND_TRANSPORT_PLAN_TRANSPORT_POSITION_2 (
   inbound_transport_plan_pos_sid      NUMBER          NOT NULL COMMENT 'unique identifier (surrogate key) of the transport plan position',
   inbound_dispo_order_pos_sid         NUMBER          NOT NULL COMMENT 'unique identifier of the order position that is transported',
   transport_end_site_sid              NUMBER          NOT NULL COMMENT 'unique identifier of the site where the transport ends',
   transport_service_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   dispo_nr                            VARCHAR(20)     NOT NULL COMMENT 'A numeric or alphanumeric value which identifies the disposition for the business.',
   transport_plan_pos_seq              NUMBER          COMMENT 'indicator for the sequence in which the activities are conducted',
   logistics_company_sid               NUMBER          NOT NULL COMMENT 'unique identifier of the hauler that transports the ordered product from one site to another site',
   transport_start_site_sid            NUMBER          COMMENT 'unique identifier of the site where the transport starts',
   plan_start_from_dt                  DATE            COMMENT 'point in time when the product delivery starts earliest',
   plan_start_to_dt                    DATE            COMMENT 'point in time when the products delivery starts latest',
   plan_end_from_dt                    DATE            COMMENT 'point in time when the products need to be at the destination or the service needs to be finished earliest',
   plan_end_to_dt                      DATE            COMMENT 'point in time when the products need to be at the destination or the service needs to be finished latest',
   transport_double_deck_fg            BOOLEAN         COMMENT 'Clasifies if the transport vehicle is able to carry double deck pallets',
   transport_capacity_qty              NUMBER(38, 5)   COMMENT 'The capacity of the transport vehicle, e.g. 1EP --> 1 transport capacity / 1DD --> 0.5 transport capacity',
   transport_vehicle_descr             VARCHAR(100)    COMMENT 'Description of the transport vehicle. Contains the transport_vehicle_type_cd (LKW, WAGGON etc) + transport_capacity_qty + weight of the vehicle.  ',
   transport_vehicle_type_cd           VARCHAR(20)     COMMENT 'Type code of the transport vehicle e.g. (CONT, LKW, LKW_KT, WAGGON).',
   logistic_temp_cd                    VARCHAR(20)     COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_INBOUND_TRANSPORT_PLAN_TRANSPORT_POSITION PRIMARY KEY (inbound_transport_plan_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'The entity contains information regarding transport for all products of a disposition, i.e. which travel route a product takes.';
