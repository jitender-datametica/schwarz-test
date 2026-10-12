/* --------------------------------------------------------------------------------
   DDL for table: t_ref_warehouse_staging_area_2
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 11:35:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_warehouse_staging_area_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT.'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION.'),
wh_staging_area_cd STRING(100) NOT NULL
OPTIONS(description='Code for the warehouse staging area to which the docking gate belongs.'),
wh_staging_area_descr STRING(250)
OPTIONS(description='Description of the warehouse staging area to which the docking area belongs.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_loc_sid, wh_staging_area_cd) NOT ENFORCED
)
OPTIONS(description='Table contains the staging areas in a warehouse. Staging areas connect docking gates with the warehouse. They are an intermediate storage and processing area.             Source:             WAWI table T170_GINGATETYPES_2             EWM table T301');