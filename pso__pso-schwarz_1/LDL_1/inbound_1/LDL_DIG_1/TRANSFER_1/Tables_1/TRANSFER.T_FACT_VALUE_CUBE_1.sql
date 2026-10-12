/*
    CREATE T_FACT_VALUE_CUBE_1
*/

CREATE TABLE transfer.t_fact_value_cube_1
(
    vc_pk_sid             NUMBER(38,0)  NOT NULL    COMMENT 'The unique identifier (surrogate key) for a particular value cube record.'
    , value_pos_cd        VARCHAR(10)  NOT NULL      COMMENT 'Identifier of the value cube position. Each metric can be a value cube position.'
    , value_amount        NUMBER(38,5)              COMMENT 'The amount corresponding to the value cube record and the value cube position combination.'
	, tmsp_insert         TIMESTAMP_LTZ(9)          COMMENT 'The point in time when this record was created in the data warehouse.'
	, tmsp_update         TIMESTAMP_LTZ(9)          COMMENT 'The point in time when this record was last updated.'
    , CONSTRAINT pk_t_fact_value_cube PRIMARY KEY ( vc_pk_sid, value_pos_cd ) NOT ENFORCED
) COMMENT = 'The fact table holding the details such as the position codes and corresponding value amount for value cube record positions.'
;