/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_package_type_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:45:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_package_type_1 (
package_type_cd STRING(100) NOT NULL
OPTIONS(description='''NFPO outer package_1 type codes for items
            CBX:  CNT_CODELIST.CODE, code list \'LIDL_PACKAGETYPE\''''),
package_type_name STRING(100)
OPTIONS(description='''NFPO outer package_1 type names for items (NETZ/TOPF/BOX usw.)
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_PACKAGETYPE\''''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (package_type_cd) NOT ENFORCED
)
OPTIONS(description='''NFPO outer package_1 type for items (NETZ/TOPF/BOX usw.)
             CBX: CNT_CODELIST_1 (code list "LIDL_PACKAGETYPE")''');