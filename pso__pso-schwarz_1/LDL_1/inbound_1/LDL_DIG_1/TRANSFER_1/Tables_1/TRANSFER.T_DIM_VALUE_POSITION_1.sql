/*
    CREATE T_DIM_CUBE_VALUE_POSITION
*/

CREATE TABLE transfer.t_dim_value_position_1
(
    value_pos_cd          VARCHAR(10) NOT NULL       COMMENT 'Identifier of the value cube position. Each metric can be a value cube position.'
    , value_pos_name_en   VARCHAR(50)               COMMENT 'English name of the position eg. product quantity.'
    , value_pos_name_de   VARCHAR(50)               COMMENT 'German name of the position eg. Bestellmenge.'
    , amount_type_cd      VARCHAR(5)                COMMENT 'This field helps identify what type of value is this position eg. value or quantity.'
    , unit_type_cd        VARCHAR(5)                COMMENT 'Describe different units (eg. quantity, currency) associated to the value cube position.'
	, tmsp_insert         TIMESTAMP_LTZ(9)  COMMENT 'The point in time when this record was created in the data warehouse.'
	, tmsp_update         TIMESTAMP_LTZ(9)  COMMENT 'The point in time when this record was last updated.'
    , CONSTRAINT pk_t_dim_value_position PRIMARY KEY ( value_pos_cd ) NOT ENFORCED
) COMMENT = 'A minor dimension that, contains one row for each value position that can be found in the value cube.'
;