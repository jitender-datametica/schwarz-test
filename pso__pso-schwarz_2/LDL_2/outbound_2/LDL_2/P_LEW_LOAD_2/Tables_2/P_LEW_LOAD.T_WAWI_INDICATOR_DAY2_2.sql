CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_indicator_day2_2 (
client_id BIGNUMERIC(38) NOT NULL OPTIONS(description='client id'),
org_unit_nr BIGNUMERIC(38) OPTIONS(description='org unit_2 number for corresponding org type'),
indicator_id BIGNUMERIC(38) NOT NULL OPTIONS(description='unique indicator id'),
indicator_type_id BIGNUMERIC(38) NOT NULL OPTIONS(description='unique indicator type id'),
dat_formdate DATE NOT NULL OPTIONS(description='day'),
org_type_id BIGNUMERIC(38) NOT NULL OPTIONS(description='unique org type id'),
cy BIGNUMERIC(38) NOT NULL OPTIONS(description='calendar_2 year')
);