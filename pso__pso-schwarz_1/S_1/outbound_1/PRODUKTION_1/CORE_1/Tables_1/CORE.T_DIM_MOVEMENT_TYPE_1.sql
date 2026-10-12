--==============================================================
-- Table: T_DIM_MOVEMENT_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MOVEMENT_TYPE_1
   generated from Powerdesigner on Thursday, November 18, 2021 12:29:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_movement_type_1 (
movement_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the movement type'),
movement_type_descr STRING(50) NOT NULL OPTIONS(description='Name for the movement type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)')
)
OPTIONS(description='Minor Dimension - for describing the different types of material movement. It states if material is going into production line as a ressource or beeing outputted as a produced material. Source - extracted from t_booking_1 attribute (persistency of a degenerated dimension).');