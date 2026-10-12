CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_internal_organisation_client (
int_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key internal organisation'),
int_org_type_cd STRING(100) NOT NULL
OPTIONS(description='type code of the internal organisation (defined by the data modeler)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (int_org_sid, client_id) NOT ENFORCED
)
OPTIONS(description='This table contains the relationship between internal organisations and erp system based clients. this relationship can be 1:n, m:1 or m:n, depending on the organisation type');