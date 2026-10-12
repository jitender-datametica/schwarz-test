CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_supplier_1 (sup_sid
OPTIONS(description='The unique identifier (surrogate key) for the supplier.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sup_name OPTIONS(description='The name by which the supplier_1 is known.'), legal_name
OPTIONS(description='The official name of the supplier_1, as shown in the company register.'), vat_nr
OPTIONS(description='The VAT identification number of the supplier.'), sup_status_cd
OPTIONS(description='The code for the lifecycle status_1 of a supplier.'), sup_status_descr
OPTIONS(description='A textual description for the lifecycle status_1 of a supplier_1 in group language, i.e. in German.'),
iso_country_cd
OPTIONS(description='The code according to ISO 3166 identifying the country_1, in which the supplier_1 is located,'),
country_name OPTIONS(description='The name of the country_1, in which the supplier_1 is located,'), city_name
OPTIONS(description='The name of the city where the supplier_1 is located.'), district_name
OPTIONS(description='The name of the district, in which the supplier_1 is located,'), zip
OPTIONS(description='The postal code of the address_1 of the supplier.'), street_name
OPTIONS(description='The name of the street where the supplier_1 is located.'), house_nr
OPTIONS(description='The number of the building within the street where the supplier_1 is located.'), lon
OPTIONS(description='The geographical longitude of the address_1 of the supplier.'), lat
OPTIONS(description='The geographical latitude of the address_1 of the supplier.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A SUPPLIER_1 IS A COMPANY THAT DELIVERS PRODUCTS TO THE SCHWARZ GROUP. SUPPLIER_1 IS ONE OUT OF POSSIBLY SEVERAL ROLES THAT CAN BE PLAYED BY A COMPANY.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_supplier_1 AS MAIN
WHERE dwh_valid_fg;