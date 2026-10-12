CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_func_person_l_err_2 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Landeskürzel'),
wh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Gesellschafts-Nummer'),
orig_store_nr BIGNUMERIC(38) NOT NULL OPTIONS(description='Fachlicher Schlüssel des Stores'),
sales_manager_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Bezirksleiter-Nr.'),
sales_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezirksleiter-Name'),
account_manager_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Vertriebsleiter-Nr.'),
account_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Vertriebsleiter-Name'),
store_manager_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Store-Manager - ID; WAWI: store_manager_id'),
store_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Store-Manager - Name; WAWI: store_manager_name'),
organisation_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Organisation - ID; WAWI: organisation_id'),
general_manager_id STRING(9) COLLATE 'und:ci' NOT NULL
OPTIONS(description='General-Manager - ID; WAWI: general_manager_id'),
general_manager_name STRING(32) COLLATE 'und:ci'
OPTIONS(description='General-Manager - Name; WAWI: general_manager_name'),
district_id STRING(200) COLLATE 'und:ci' NOT NULL OPTIONS(description='district_id'),
dat_valid_from DATE NOT NULL OPTIONS(description='Gultigkeitsbeginn der Artikelnummer (WAWI)'),
dat_valid_until DATE OPTIONS(description='Gültig bis, wird vom Vorsystem Wawi geliefert'),
dat_dayend DATE OPTIONS(description='Tagesabschlussdatum dayend date from file'),
load_id BIGNUMERIC(38) NOT NULL OPTIONS(description='ID der Transformation'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Datawarehouse aktualisiertes Datum')
);