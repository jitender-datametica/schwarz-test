/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_org_store_contact_1
   generated from Powerdesigner on Montag, 29. Januar 2024 10:35:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_org_store_contact_1 (
st_loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key der Filiale; column name before the trans-all migration: st_loc_sid'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT;column name before the trans-all migration: client_id'),
dat_rec_start DATE NOT NULL
OPTIONS(description='Gültigkeitsdatum von; column name before the trans-all migration: dat_rec_start'),
dat_rec_end DATE NOT NULL
OPTIONS(description='Gültigkeitsdatum bis; column name before the trans-all migration: dat_rec_end'),
zipcode STRING(15) COLLATE 'und:ci'
OPTIONS(description='Filial-Postleitzahl; column name before the trans-all migration: zipcode'),
city STRING(100) COLLATE 'und:ci' OPTIONS(description='Filial-Ort; column name before the trans-all migration: city'),
street STRING(70) COLLATE 'und:ci'
OPTIONS(description='Filial-Adresse; column name before the trans-all migration: street'),
phone STRING(50) COLLATE 'und:ci'
OPTIONS(description='Filial-Telefonnummer; column name before the trans-all migration: phone'),
zipcode_postbox STRING(15) COLLATE 'und:ci'
OPTIONS(description='Column name before the trans-all migration: zipcode_postbox'),
postbox STRING(50) COLLATE 'und:ci' OPTIONS(description='Column name before the trans-all migration: postbox'),
fax STRING(35) COLLATE 'und:ci' OPTIONS(description='Column name before the trans-all migration: fax'),
modem STRING(50) COLLATE 'und:ci' OPTIONS(description='Column name before the trans-all migration: modem'),
pol_region_sid BIGNUMERIC(38,0)
OPTIONS(description='Surrogate identifier of the main administrative reagion in the political country_1            WAWI: WAWI Instance and T008_STORE.C008_EXC_MAIN_REGION'),
pol_region_cd STRING(100)
OPTIONS(description='Code of the first level of the administrative hierarchy_1 in the political country_1            WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME'),
load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'),
PRIMARY KEY (st_loc_sid, dat_rec_start) NOT ENFORCED
) OPTIONS(description='contact_1 and address_1 information of stores             WAWI: T008_STORE_1');