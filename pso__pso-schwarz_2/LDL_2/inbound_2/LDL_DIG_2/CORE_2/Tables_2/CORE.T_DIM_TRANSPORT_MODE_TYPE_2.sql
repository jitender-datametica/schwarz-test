/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_TRANSPORT_MODE_TYPE_2
   GENERATED FROM POWERDESIGNER ON Freitag, 21. Februar 2025 15:54:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRANSPORT_MODE_TYPE_2 (
   TRANSPORT_MODE_TYPE_CD              VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the transportation mode used. Example: ZTRK.',
   TRANSPORT_MODE_TYPE_DESCR           VARCHAR(250)    NOT NULL COMMENT 'The description for the type of the transportation mode used. Example: Container, 	Truck Czech Republic Street',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_TRANSPORT_MODE_TYPE PRIMARY KEY (TRANSPORT_MODE_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'This minor dimension describes the type of the transportation mode used. It indicates whether it is a container, trailer, ship, airplane, truck etc.';
