CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_transport_plan_crossdock_transport_movement (
tour_id STRING(100) NOT NULL
OPTIONS(description='An internally generated identifier that uniquely identifies a specific transport tour or vehicle route.'),
inbound_dispo_order_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition position.'),
order_reference_nr STRING(250) NOT NULL
OPTIONS(description='14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)'),
vehicle_id STRING(20) NOT NULL OPTIONS(description='The unique identifier of the vehicle used for transport.'),
product_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier of the product variant. (GTIN based )'),
transport_start_site_sid BIGNUMERIC
OPTIONS(description='A unique identifier of the site where the transport starts ( supplier warehouse or crossdock)'),
transport_end_site_sid BIGNUMERIC NOT NULL
OPTIONS(description='unique identifier of the site where the transport ends (crossdock or RDC='),
inbound_logistics_partner_name STRING(100) OPTIONS(description='A name of hauler transporting goods'),
logistics_partner_name STRING(100) OPTIONS(description='A name of hauler transporting goods'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier of the delivering party, e.g. the supplier.'),
supplier_sid BIGNUMERIC NOT NULL
OPTIONS(description='A unique identifier for the logistics company (hauler) handling the transport.'),
dept_arrival_tmsp TIMESTAMP
OPTIONS(description='The exact time a truck (LKW) arrives at the departure premises delivering the goods from the previous location'),
dept_checkin_tmsp TIMESTAMP
OPTIONS(description='The time the driver officially checks in at the departure.This often happens shortly after arrival and involves submitting paperwork.'),
dept_departure_tmsp TIMESTAMP
OPTIONS(description='The time when the truck leaves the  departure premises after all tasks (unloading, paperwork, etc.) are finished.'),
dept_gate_id STRING(20) OPTIONS(description='Destinatiom warehouse gate'),
dest_arrival_tmsp TIMESTAMP
OPTIONS(description='The exact time a truck (LKW) arrives at the destination premises delivering the goods from the previous location'),
dest_checkin_tmsp TIMESTAMP
OPTIONS(description='The time the driver officially checks in at the destination.This often happens shortly after arrival and involves submitting paperwork.'),
dest_departure_tmsp TIMESTAMP
OPTIONS(description='The time when the truck leaves the destination premises after all tasks (unloading, paperwork, etc.) are finished.'),
dest_gate_id STRING(20) OPTIONS(description='Departure warehouse gate'),
pallet_cnt BIGNUMERIC OPTIONS(description='A count of transported pallets'),
delay_reason_hauler_cd STRING(20) OPTIONS(description='The code for the status of the product.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (tour_id, product_variant_sid) NOT ENFORCED
)
OPTIONS(description='The entity contains information regarding transport for all products of a disposition, i.e. which travel route a product takes.');