/*
    CREATE T_REL_VALUE_CUBE_DOMAIN_HIERARCHY_1
*/



CREATE TABLE transfer.t_rel_value_cube_domain_hierarchy_1
(
    data_domain_cd        VARCHAR(50)  NOT NULL      COMMENT 'Identifier code for data domains (eg. department name can be a data domain).'
    , cube_level_type_cd  VARCHAR(50)  NOT NULL      COMMENT 'Identifier for the level type of value cube (eg. order, product, customer).'
    , cube_descr          VARCHAR(150)               COMMENT 'Description of the value cube.'
    , value_pos_cd        VARCHAR(10)   NOT NULL      COMMENT 'Identifier of the value cube position. Each metric can be a value cube position.'
    , value_pos_descr     VARCHAR(150)               COMMENT 'Description of the value cube position.'
    , agg_value_logic     VARCHAR(350)               COMMENT 'Logic describing the aggregation for subtotals and totals.'
    , factor_sign         NUMBER(38,0)               COMMENT 'A binary indicator defining the multiplicative factor as +1 or -1.'
    , display_order_nr    NUMBER(38,0)               COMMENT 'Numbers displaying the visual sequential order.'
	, tmsp_insert         TIMESTAMP_LTZ(9)           COMMENT 'The point in time when this record was created in the data warehouse.'
	, tmsp_update         TIMESTAMP_LTZ(9)           COMMENT 'The point in time when this record was last updated.'
    , CONSTRAINT pk_t_rel_value_cube_domain_hierarchy PRIMARY KEY ( data_domain_cd, cube_level_type_cd, value_pos_cd ) NOT ENFORCED
) COMMENT = 'The relational table holding the logic needed to define the value cubes output.'
;