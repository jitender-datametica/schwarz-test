CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_transport_plan_direct_transport_movement_2 (
inbound_dispo_order_sid BIGNUMERIC NOT NULL OPTIONS(description='Unique identifier of the corresponding dispositon.'),
order_reference_nr STRING(250) NOT NULL
OPTIONS(description='14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)'),
vehicle_id STRING(20) NOT NULL OPTIONS(description='The unique identifier of the vehicle used for transport.'),
transport_start_site_sid BIGNUMERIC NOT NULL
OPTIONS(description='A unique identifier of the site where the transport starts ( supplier_2 warehouse)'),
transport_end_site_sid BIGNUMERIC OPTIONS(description='A unique identifier of the site where the transport ends (RDC)'),
supplier_sid BIGNUMERIC NOT NULL
OPTIONS(description='A unique identifier for the logistics company (hauler) handling the transport.'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier of the delivering party, e.g. the supplier.'),
ready_for_collection_dt DATE
OPTIONS(description='This time when the carrier or a responsible party was notified that the goods were available to be collected.'),
latest_delivery_dt DATE OPTIONS(description='The planned reception time at ELM.'),
latest_loading_release_dt DATE
OPTIONS(description='The last possible time a truck can arrive and pick up goods to ensure they arrive on time. This is a target timestamp that\'s either set by the carrier or is a predefined timestamp.'),
advised_for_collection_dt DATE
OPTIONS(description='The initial planned timestamp for goods collection, as set by the hauler. This represents the first scheduled date and time for pickup.'),
collected_dt DATE OPTIONS(description='The actual time the goods are picked up.'),
unloaded_at_wh_dt DATE OPTIONS(description='The time the truck driver states they were at the warehouse.'),
delay_reason_hauler_descr STRING(100)
OPTIONS(description='A description for the specific reason for a transport delay caused by the hauler or logistics company.'),
delay_reason_supplier_descr STRING(100)
OPTIONS(description='A description for the specific reason for a transport delay caused by the supplier_2 or logistics company.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (order_reference_nr, vehicle_id) NOT ENFORCED
)
OPTIONS(description='his entity provides detailed transport information for all products within a disposition, managed through a Cross-Docking system. The data outlines the travel route for goods that are transported from a supplier_2\'s warehouse to a cross-docking facility, where they are rerouted to another  cross-docking facility or Regional Distribution Center (RDC).');