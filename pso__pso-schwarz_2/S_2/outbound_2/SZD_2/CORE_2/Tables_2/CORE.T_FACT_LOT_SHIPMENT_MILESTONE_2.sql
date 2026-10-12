/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_LOT_SHIPMENT_MILESTONE_2
   generated from Powerdesigner on Freitag, 2. August 2024 08:21:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_lot_shipment_milestone_2 (
lot_product_instance_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the lot.'),
lot_milestone_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - A milestone is an event in the lot lifecycle. Table contains the list of the possible events'),
event_tmsp TIMESTAMP NOT NULL OPTIONS(description='The timestamp when the event took place'),
lot_milestone_result_cd STRING(50) NOT NULL
OPTIONS(description='A milestone is an event in the lot lifecycle. Table contains the list of the possible events'),
event_dt DATE NOT NULL OPTIONS(description='Natural Key/Business Key - A date when measurement was taken'),
milestone_dt DATE OPTIONS(description='Business date of a milestone (e.g. date when gas measurement was done)'),
due_dt DATE OPTIONS(description='Due date of a milestone'),
done_dt DATE OPTIONS(description='Done date of milestone (date when system receives the data)'),
lot_milestone_result_evaluation_dt DATE OPTIONS(description='Event Result represented as a date'),
lot_milestone_result_evaluation_txt STRING(1000)
OPTIONS(description='Descriptive attribute - Text  Description of Lot Event Result'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_product_instance_group_sid, lot_milestone_cd, event_tmsp) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - Transaction - A milestone is an event in the lot lifecycle. There are around 60 milestones in VMT such as "shipment release" or "producer booking". Some milestones are triggered by external events/interfaces, others resolved by manual actions. - Source - VMT');