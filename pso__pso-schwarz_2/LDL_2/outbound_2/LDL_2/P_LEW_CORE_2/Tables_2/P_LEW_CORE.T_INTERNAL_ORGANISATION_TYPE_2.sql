CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_internal_organisation_type_2 (
int_org_type_cd STRING(100) NOT NULL
OPTIONS(description='type code of the internal organisation (defined by the data modeler)'),
int_org_type_name STRING(100) OPTIONS(description='name of the internal organisation type'),
int_org_type_descr STRING(250) OPTIONS(description='description of the organisation type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (int_org_type_cd) NOT ENFORCED
)
OPTIONS(description='Ths table contains the types of internal organizations stored in t_organisational_unit. It contains organisation types on a level comparable to country_2 or client, but having different business backgrounds and therefore different details.');