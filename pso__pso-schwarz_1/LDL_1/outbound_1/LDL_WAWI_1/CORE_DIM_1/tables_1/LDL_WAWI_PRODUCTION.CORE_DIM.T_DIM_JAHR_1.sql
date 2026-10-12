CREATE OR REPLACE TABLE core_dim.t_dim_jahr_1 (
jahr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
PRIMARY KEY (jahr) NOT ENFORCED
) OPTIONS(description='Kalenderjahr, Format YYYY');