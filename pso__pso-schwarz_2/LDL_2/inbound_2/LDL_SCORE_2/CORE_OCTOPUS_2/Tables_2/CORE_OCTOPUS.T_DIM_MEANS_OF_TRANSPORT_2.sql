CREATE TABLE CORE_OCTOPUS.T_DIM_MEANS_OF_TRANSPORT_2 (
   means_of_transport_cd               VARCHAR(20)     NOT NULL COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)',
   means_of_transport_descr            VARCHAR(100)    COMMENT 'A textual description for the means_of_transport_cd written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_MEANS_OF_TRANSPORT PRIMARY KEY (means_of_transport_cd) NOT ENFORCED 
)  COMMENT = 'This table contains how the goods are transported. Either by a truck (LKW), Kühltrocken-LKW, Kühl_2-LKW, Waggon or Container. ';
