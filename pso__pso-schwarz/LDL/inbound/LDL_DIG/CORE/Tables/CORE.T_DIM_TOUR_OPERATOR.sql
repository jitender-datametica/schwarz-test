CREATE TABLE CORE.T_DIM_TOUR_OPERATOR (
	TOUR_OPERATOR_CD VARCHAR(50) NOT NULL COMMENT 'The code for the tour operator',
	TOUR_OPERATOR_NAME VARCHAR(100) NOT NULL COMMENT 'The name of tour operator',
	TOUR_OPERATOR_TYPE_CD VARCHAR(20) COMMENT 'Differentiates the area of Tour Operator LT cooperates with (Travel , Insurance)',
	TOUR_OPERATOR_CONTRACT_TYPE_CD VARCHAR(20) COMMENT 'Code for the type of contract for Tour Operator LT ( Iframe , mittelbar,  unmittelbar)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
    SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_DIM_TOUR_OPERATOR PRIMARY KEY (TOUR_OPERATOR_CD)
)COMMENT='This minor dimension defines the tour operator details'
;