--==============================================================
-- Table: T_DIM_MATERIAL_MOVEMENT_TYPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MATERIAL_MOVEMENT_TYPE
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:12 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_material_movement_type (
material_movement_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the movement type'),
material_movement_type_descr STRING(250) NOT NULL OPTIONS(description='Name for the movement type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (material_movement_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - for describing the different types of material movement. It states if material is going into production line as a ressource or beeing outputted as a produced material. Source - extracted from t_booking attribute (persistency of a degenerated dimension).');