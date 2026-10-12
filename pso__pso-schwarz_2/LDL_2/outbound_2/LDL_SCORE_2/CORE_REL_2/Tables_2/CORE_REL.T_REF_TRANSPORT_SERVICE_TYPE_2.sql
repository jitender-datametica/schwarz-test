--==============================================================
-- Table: t_ref_transport_service_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_transport_service_type_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_transport_service_type_2 (
transport_service_type_cd STRING(7) NOT NULL
OPTIONS(description='The code for the type of the transport service, i.e. Vorlauf,Zwischenlauf,Hauptlauf'),
transport_service_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the transport_service_type i.e. Vorlauf,Zwischenlauf,Hauptlauf'),
transport_service_type_descr_de STRING(100)
OPTIONS(description='German description for the transport_service_type:Vorlauf,Zwischenlauf,Hauptlauf'),
transport_service_type_descr_en STRING(100)
OPTIONS(description='English description for the transport_service_type:Vorlauf,Zwischenlauf,Hauptlauf'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (transport_service_type_cd) NOT ENFORCED
)
OPTIONS(description='Represents the type of transport service.             There are several types to distinguish here. If the goods are picked up by a supplier_2, this is referred to as an internal lead time. If the goods are delivered directly from the supplier_2 to the next crossdock, this is called (externer Vorlauf). Transport between two crossdocks is referred to as (Zwischenlauf).              Deliveries from the last crossdock to the Lidl regional organization are called (Hauptlauf).');