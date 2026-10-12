/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_WAREHOUSE_TRANSPORTATION_UNIT_REL
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juni 2024 14:15:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_warehouse_transportation_unit_rel (
wh_transportation_unit_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique surrogate key for the warehouse transportation unit. The SID is generated based on wh_transportation_unit_nr, sap_client_id and sap_system_name. '),
wh_transportation_unit_nr STRING(50)
OPTIONS(description='The unique internal ID for the warehouse transportation unit delivering the products associated with a given order line. This internal ID is generated for the originally provided warehouse transportation unit number by the external transportation service provider (alt_wh_transportation_unit_nr).  In case the alternate warehouse transportation unit number changes, the internal ID will remain the same and there will be another row for the new unique combination of alt_wh_transportation_unit_nr and wh_transportation_unit_nr'),
alt_wh_transportation_unit_nr STRING(50)
OPTIONS(description='An alternative unique identifier for the warehouse transportation unit that is maintained manually by the warehouse employees.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (wh_transportation_unit_sid) NOT ENFORCED
)
OPTIONS(description='A fact table that stores the relation between the natural key from the system and the alternative one that is maintained manually for warehouse transportation units.');