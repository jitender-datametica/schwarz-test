CREATE OR REPLACE TABLE core_dim.t_dim_monat_2 (
monat_2 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
jahr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
PRIMARY KEY (monat_2) NOT ENFORCED
) OPTIONS(description='Kalendermonat, Format YYYYMM');