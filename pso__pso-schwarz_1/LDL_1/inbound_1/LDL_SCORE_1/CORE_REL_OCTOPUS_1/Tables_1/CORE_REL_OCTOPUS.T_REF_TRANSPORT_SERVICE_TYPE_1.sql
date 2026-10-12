CREATE TABLE CORE_REL_OCTOPUS.T_REF_TRANSPORT_SERVICE_TYPE_1 (
   transport_service_type_cd           VARCHAR(7)      NOT NULL COMMENT 'The code for the type of the transport service, i.e.
            Vorlauf,Zwischenlauf,Hauptlauf',
   transport_service_type_descr        VARCHAR(100)    NOT NULL COMMENT 'A textual description for the transport_service_type i.e. Vorlauf,Zwischenlauf,Hauptlauf',
   transport_service_type_descr_de     VARCHAR(100)    COMMENT 'German description for the transport_service_type:Vorlauf,Zwischenlauf,Hauptlauf',
   transport_service_type_descr_en     VARCHAR(100)    COMMENT 'English description for the transport_service_type:Vorlauf,Zwischenlauf,Hauptlauf',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_TRANSPORT_SERVICE_TYPE PRIMARY KEY (transport_service_type_cd) NOT ENFORCED 
)  COMMENT = 'Represents the type of transport service.
             There are several types to distinguish here. If the goods are picked up by a supplier_1, this is referred to as an internal lead time. If the goods are delivered directly from the supplier_1 to the next crossdock, this is called (externer Vorlauf). Transport between two crossdocks is referred to as (Zwischenlauf). 
             Deliveries from the last crossdock to the Lidl regional organization are called (Hauptlauf). ';
