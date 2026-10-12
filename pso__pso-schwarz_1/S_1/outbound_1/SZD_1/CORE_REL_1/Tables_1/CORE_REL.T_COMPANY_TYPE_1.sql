/* --------------------------------------------------------------------------------
   DDL for table: T_COMPANY_TYPE_1
   generated from Powerdesigner on Freitag, 13. Oktober 2023 12:23:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_company_type_1 (
company_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of the company company (Supplier_1 ,  Hauler,  Handling agents , etc) to which t_company_1 references on.'),
company_type_descr STRING(250)
OPTIONS(description='A textual description for the company_type_cd written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (company_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The minor dimension that contain site type for an selected company (Supplier_1 ,  Hauler,  Handling agents , etc) - Source - Manual');