CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_data_delivery_classification_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT'),
src_region_cd STRING(255) NOT NULL OPTIONS(description='Identifier of the country_1 region_1'),
src_period_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='period identifier from the source'),
period_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='year the period is related to'),
period_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Perioden-Typ-ID'),
dsc_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the data source company'),
lfl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the like for like class (currently 0 or 1)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung')
)
OPTIONS(description='table holds information about the data delivered by certain data providers forcertain periods and clients');