/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_SHIPMENT_MILESTONE
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_container_shipment_milestone (
container_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the container.'),
container_milestone_cd STRING(50) NOT NULL
OPTIONS(description='A milestone is an event in the container lifecycle. Table contains the list of the possible events'),
event_tmsp TIMESTAMP NOT NULL OPTIONS(description='The timestamp when the event took place'),
event_dt DATE NOT NULL OPTIONS(description='A date when measurement was taken'),
milestone_dt DATE
OPTIONS(description='Descriptive Attribute - Business date of a milestone (e.g. date when gas measurement was done)'),
due_dt DATE OPTIONS(description='Descriptive Attribute - Due date of a milestone'),
done_dt DATE OPTIONS(description='Descriptive Attribute - Done date of milestone (date when system receives the data)'),
container_milestone_result_evaluation_dt DATE
OPTIONS(description='Descriptive Attribute - Event Result represented as a date'),
container_milestone_result_evaluation_txt STRING(1000)
OPTIONS(description='Descriptive Attribute -Text Description of Event Result'),
container_milestone_result_cd STRING(50)
OPTIONS(description='A milestone is an event in the container lifecycle. Table contains the list of the possible event results'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (container_resource_item_sid, event_tmsp, container_milestone_cd) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Containers start existing when the actual time of shipment ("ATD") is near. Then, the producer enters container numbers and their content to the lots\' container load plan. Containers have individual milestones, too. When all container milestones of a type are resolved, this may trigger the according lot milestone. For example, if all containers are unloaded, the lots\' unloading milestone state changes to resolved  - Source - VMT             ');