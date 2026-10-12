CREATE OR REPLACE TABLE core_dim.t_dim_monat (
monat BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
jahr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
PRIMARY KEY (monat) NOT ENFORCED
) OPTIONS(description='Kalendermonat, Format YYYYMM');