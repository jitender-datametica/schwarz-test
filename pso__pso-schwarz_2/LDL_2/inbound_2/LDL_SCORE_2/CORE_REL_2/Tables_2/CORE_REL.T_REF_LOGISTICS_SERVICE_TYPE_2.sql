--==============================================================
-- Table: t_ref_logistics_service_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_logistics_service_type_2
   generated from Powerdesigner on Donnerstag, 6. Juni 2024 09:22:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_LOGISTICS_SERVICE_TYPE_2 (
   logistics_service_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the logistics service, e.g. short-time storage.',
   logistics_service_type_descr        VARCHAR(100)    NOT NULL COMMENT 'A textual description for the logistics_service_type_cd written out in group language (German).',
   logistics_service_type_descr_de     VARCHAR(100)    COMMENT 'A textual description for the logistics_service_type_cd written out in German.',
   logistics_service_type_descr_en     VARCHAR(100)    COMMENT 'A textual description for the logistics_service_type_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_LOGISTICS_SERVICE_TYPE PRIMARY KEY (logistics_service_type_cd) NOT ENFORCED 
)  COMMENT = 'Describes which service is offered in the disposition (warehouse logistics). In this case its WU = Warenumschlag, which means that the goods are brought to a crossdock which are picked from that one to the next destination.';
