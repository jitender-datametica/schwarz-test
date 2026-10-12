--==============================================================
-- Table: T_DIM_SHIFT_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SHIFT_TYPE_1
   generated from Powerdesigner on Tuesday, March 22, 2022 6:33:11 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_core.t_dim_shift_type_1 (
shift_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the production shift type'),
shift_type_descr STRING(250) NOT NULL OPTIONS(description='Name for the production shift type'),
shift_type_descr_de STRING(250) NOT NULL OPTIONS(description='Name for the production shift type'),
shift_type_descr_en STRING(250) NOT NULL OPTIONS(description='Name for the production shift type'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (shift_type_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - for describing the differnt shift types. Source - filled manually. Table for describing the different shift types. The Schwarz Production divides its working day into different shifts, which have shift types e.g. morning / late / night shift. Timerange of a shift can vary.');