CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_indicator_day (
client_id BIGNUMERIC(38) NOT NULL OPTIONS(description='client id'),
org_type_id BIGNUMERIC(38) NOT NULL OPTIONS(description='unique org type id'),
org_unit_nr BIGNUMERIC(38) OPTIONS(description='org unit number for corresponding org type'),
indicator_id BIGNUMERIC(38) NOT NULL OPTIONS(description='unique indicator id'),
indicator_type_id BIGNUMERIC(38) NOT NULL OPTIONS(description='unique indicator type id'),
cy BIGNUMERIC(38) NOT NULL OPTIONS(description='calendar year'),
dat_formdate DATE NOT NULL OPTIONS(description='day'),
val_indicator NUMERIC(18,4) OPTIONS(description='value of corresponding indicator'),
timestamp_fn DATETIME NOT NULL OPTIONS(description='timestamp load file (last write access; DWHC2)'),
dat_dayend DATE NOT NULL OPTIONS(description='dayend date from file'),
load_id BIGNUMERIC(38) NOT NULL OPTIONS(description='transformation ID')
);