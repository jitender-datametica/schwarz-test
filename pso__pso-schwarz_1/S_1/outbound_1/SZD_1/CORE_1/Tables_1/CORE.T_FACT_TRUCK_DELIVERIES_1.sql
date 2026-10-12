CREATE TABLE IF NOT EXISTS szd_core.t_fact_truck_deliveries_1 (
supplier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the supplier.'),
hauler_party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the hauler.'),
recipient_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the recipient.'),
dispoweek_dt DATE NOT NULL OPTIONS(description='The date of the first day of the dispo week.'),
outbound_dt DATE NOT NULL OPTIONS(description='The date on which the goods were dispatched.'),
arrival_dt DATE NOT NULL OPTIONS(description='The date when the goods arrived at the recipient.'),
promotion_dt DATE NOT NULL OPTIONS(description='The promotion date.'),
planned_delivery_dt DATE NOT NULL OPTIONS(description='The planned delivery date.'),
delivery_dt DATE NOT NULL OPTIONS(description='The delivery date.'),
delivery_note_nr STRING(50) NOT NULL OPTIONS(description='The business identification number of the delivery note.'),
delivery_date_fixed_fg BOOL NOT NULL OPTIONS(description='Flag indicating that the delivery date is fixed.'),
total_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fact - additive - The total count of delivery trucks.'),
outbound_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fact - additive - The count of trucks that has started.'),
arrived_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of trucks that arrived at the recipient.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (supplier_party_sid, hauler_party_sid, recipient_party_sid, dispoweek_dt, outbound_dt, arrival_dt,
 promotion_dt, planned_delivery_dt, delivery_dt, delivery_date_fixed_fg) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by week, supplier_1, hauler, recipient - Aggregate - Contains analytical facts regarding the count of trucks delivering goods to a recipient. - Source - LExIS');