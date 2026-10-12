CREATE TABLE CORE_REL_OCTOPUS.T_REF_MEANS_OF_TRANSPORT (
   means_of_transport_cd               VARCHAR(20)     NOT NULL COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)',
   means_of_transport_descr            VARCHAR(100)    NOT NULL COMMENT 'Means of transport used in the delivery of goods:Includes:
            LKW - truck
            CONT - container
            SCHIFF -ship
            BAHN - train',
   means_of_transport_descr_de         VARCHAR(100)    COMMENT 'A textual description for the means_of_transport_cd written out in German.',
   means_of_transport_descr_en         VARCHAR(100)    COMMENT 'A textual description for the means_of_transport_cd written out in English.',
   elm_means_of_transport_id           NUMBER          COMMENT 'ELM: elm_transtypeid',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_MEANS_OF_TRANSPORT PRIMARY KEY (means_of_transport_cd) NOT ENFORCED 
)  COMMENT = 'Means of transport describes the type of transport:  truck (LKW), Kühltrocken-LKW, Kühl-LKW, Waggon or Container. ';
