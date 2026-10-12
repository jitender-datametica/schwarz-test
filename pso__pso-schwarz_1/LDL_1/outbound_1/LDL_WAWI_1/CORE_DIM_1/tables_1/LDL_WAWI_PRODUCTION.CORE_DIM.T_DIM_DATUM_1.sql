CREATE OR REPLACE TABLE core_dim.t_dim_datum_1 (
datum DATE NOT NULL OPTIONS(description='Manuell befüllt'),
monat_1 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
jahr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
PRIMARY KEY (datum) NOT ENFORCED
) OPTIONS(description='Datum, Format YYYY-MM_1-DD');