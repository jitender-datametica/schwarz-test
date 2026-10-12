--==============================================================
-- Table: t_dim_transport_service_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_transport_service_type_1
   generated from Powerdesigner on Mittwoch, 7. August 2024 10:45:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRANSPORT_SERVICE_TYPE_1 (
   transport_service_type_cd           VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"',
   transport_service_type_descr        VARCHAR(100)    COMMENT 'A textual description for the transport_service_type_descr written out in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_TRANSPORT_SERVICE_TYPE PRIMARY KEY (transport_service_type_cd) NOT ENFORCED 
)  COMMENT = 'Represents the type of transport is conducted. 
             There are several types to distinguish here. If the goods are picked up by a supplier_1, this is referred to as an internal lead time. If the goods are delivered directly from the supplier_1 to the next crossdock, this is called (externer Vorlauf). Transport between two crossdocks is referred to as (Zwischenlauf). 
             Deliveries from the last crossdock to the Lidl regional organization are called (Hauptlauf). ';
