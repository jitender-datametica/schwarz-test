CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_data_source_company (
dsc_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the data source company'),
dsc_name STRING(100) OPTIONS(description='name of the data source company'),
dsc_type_cd STRING(100) OPTIONS(description='type of the data source company (INTERNAL,EXTERNAL)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung')
) OPTIONS(description='table contains the list of data source companies providing data for liam lift');