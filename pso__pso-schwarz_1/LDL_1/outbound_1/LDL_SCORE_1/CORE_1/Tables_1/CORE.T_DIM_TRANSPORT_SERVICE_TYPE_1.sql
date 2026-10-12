--==============================================================
-- Table: t_dim_transport_service_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_transport_service_type_1
   generated from Powerdesigner on Mittwoch, 7. August 2024 10:45:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_transport_service_type_1 (
transport_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"'),
transport_service_type_descr STRING(100)
OPTIONS(description='A textual description for the transport_service_type_descr written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (transport_service_type_cd) NOT ENFORCED
)
OPTIONS(description='Represents the type of transport is conducted.              There are several types to distinguish here. If the goods are picked up by a supplier_1, this is referred to as an internal lead time. If the goods are delivered directly from the supplier_1 to the next crossdock, this is called (externer Vorlauf). Transport between two crossdocks is referred to as (Zwischenlauf).              Deliveries from the last crossdock to the Lidl regional organization are called (Hauptlauf). ');