CREATE TABLE P_LEW_CORE.T_WAWI_REF_WAWI_DISCOUNT_2
(
client_id SMALLINT NOT NULL,
discount_nr_wawi INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
discount_desc VARCHAR(50) COLLATE 'en-ci' NOT NULL,
discount_type_id SMALLINT NOT NULL,
discount_booking_type_id SMALLINT NOT NULL,
dat_last_export TIMESTAMP(0) ,
dat_storno TIMESTAMP(0) ,
dat_dayend DATE NOT NULL,
load_id INTEGER NOT NULL);



