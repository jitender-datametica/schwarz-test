--==============================================================
-- Table: t_dim_transport_plan_position_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_transport_plan_position_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:47:36
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRANSPORT_PLAN_POSITION_2 (
   inbound_transport_plan_pos_sid      NUMBER          NOT NULL COMMENT 'Unique identifier (surrogate key) of the transport plan position',
   inbound_dispo_order_pos_sid         NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the disposition position.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   transport_plan_pos_seq              NUMBER          COMMENT 'indicator for the sequence in which the activities are conducted',
   transport_start_site_sid            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   transport_end_site_sid              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   plan_start_from_dt                  DATE            COMMENT 'Point in time when the product delivery starts earliest',
   plan_end_to_dt                      DATE            COMMENT 'Point in time when the products need to be at the destination or the service needs to be finished latest',
   plan_end_from_dt                    DATE            COMMENT 'Point in time when the products need to be at the destination or the service needs to be finished earliest',
   plan_start_to_dt                    DATE            COMMENT 'Point in time when the products delivery starts latest',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_TRANSPORT_PLAN_POSITION PRIMARY KEY (inbound_transport_plan_pos_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'The entity contains information regarding transport for all products of a disposition, i.e. which travel route a product takes.';
