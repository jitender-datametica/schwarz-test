CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_internal_organisation (
int_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key internal organisation'),
int_org_type_cd STRING(100) NOT NULL OPTIONS(description='type code of the internal organisation'),
int_org_nr STRING(100) NOT NULL OPTIONS(description='identifier of the internal organisation in the source system'),
int_org_name STRING(100) OPTIONS(description='name of the internal organisation'),
int_org_descr STRING(250) OPTIONS(description='description of the onternal organisation'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (int_org_sid) NOT ENFORCED
)
OPTIONS(description='This table contains the list of internal organizations of various types. This table is not replacing the already modeled tables containing ERP-related organisational units like client, store or warehouse. It contains organisation types on a level comparable to country or client, but having different business backgrounds and therefore different details.');