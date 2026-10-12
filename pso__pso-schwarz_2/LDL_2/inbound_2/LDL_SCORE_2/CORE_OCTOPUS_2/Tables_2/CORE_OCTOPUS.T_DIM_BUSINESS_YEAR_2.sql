CREATE TABLE CORE_OCTOPUS.T_DIM_BUSINESS_YEAR_2 (
   bus_year                            NUMBER          NOT NULL COMMENT 'Business Year',
   prev_1y_bus_year                    NUMBER          NOT NULL COMMENT 'Previous Business Year',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_BUSINESS_YEAR PRIMARY KEY (bus_year) NOT ENFORCED 
)  COMMENT = 'Annual information is listed here. ';
