/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_NOTIFICATION_1
   generated from Powerdesigner on Dienstag, 13. Mai 2025 13:10:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_delivery_notification_1 (
internal_handling_unit_nr STRING(250) NOT NULL
OPTIONS(description='Business / Natural Key - The unique identification number of the handling unit.'),
packaging_material_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the packaging material as used in the source system.'),
internal_guid_nr STRING(100) NOT NULL
OPTIONS(description='The internal global unique identifier of this delivery announcement.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (internal_handling_unit_nr) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - Stores delivery notifications data related to handling units. A delivery notification is a notification of a supplier_1 to the recipient that a delivery will be made. - Source - LExIS');