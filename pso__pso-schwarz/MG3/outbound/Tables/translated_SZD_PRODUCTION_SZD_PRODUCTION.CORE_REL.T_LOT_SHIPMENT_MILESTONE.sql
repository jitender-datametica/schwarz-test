CREATE OR REPLACE TABLE szd_production_core_rel.t_lot_shipment_milestone (
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
lot_milestone_cd STRING(50) NOT NULL
OPTIONS(description='A milestone is an event in the lot lifecycle. Table contains the list of the possible events'),
event_tmsp TIMESTAMP NOT NULL OPTIONS(description='The timestamp when the event took place'),
event_dt DATE NOT NULL OPTIONS(description='A date when measurement was taken'),
milestone_dt DATE
OPTIONS(description='Descriptive Attribute - Business date of a milestone (e.g. date when gas measurement was done)'),
due_dt DATE OPTIONS(description='Descriptive Attribute - Due date of a milestone'),
done_dt DATE OPTIONS(description='Descriptive Attribute - Done date of milestone (date when system receives the data)'),
lot_milestone_result_evaluation_dt DATE
OPTIONS(description='Descriptive Attribute - Event Result represented as a date'),
lot_milestone_result_evaluation_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - Text  Description of Lot Event Result'),
lot_milestone_result_cd STRING(50)
OPTIONS(description='A milestone is an event in the lot lifecycle. Table contains the list of the possible events'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_product_instance_group_sid, event_tmsp, lot_milestone_cd) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - A milestone is an event in the lot lifecycle. There are around 60 milestones in VMT such as\"shipment release\" or\"producer booking\". Some milestones are triggered by external events/interfaces, others resolved by manual actions - Source - VMT');