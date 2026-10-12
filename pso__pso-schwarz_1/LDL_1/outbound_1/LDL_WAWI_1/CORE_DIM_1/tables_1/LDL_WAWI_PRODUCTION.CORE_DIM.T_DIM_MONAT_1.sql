CREATE OR REPLACE TABLE core_dim.t_dim_monat_1 (
monat_1 BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
jahr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Manuell befüllt'),
PRIMARY KEY (monat_1) NOT ENFORCED
) OPTIONS(description='Kalendermonat, Format YYYYMM');