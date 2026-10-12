CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_store_contact_1 (st_loc_sid
OPTIONS(description='Surrogate Key der Filiale; column name before the trans-all migration: st_loc_sid'), client_id
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT;column name before the trans-all migration: client_id'), dat_rec_start
OPTIONS(description='Gültigkeitsdatum von; column name before the trans-all migration: dat_rec_start'), dat_rec_end
OPTIONS(description='Gültigkeitsdatum bis; column name before the trans-all migration: dat_rec_end'), zipcode
OPTIONS(description='Filial-Postleitzahl; column name before the trans-all migration: zipcode'), city
OPTIONS(description='Filial-Ort; column name before the trans-all migration: city'), street
OPTIONS(description='Filial-Adresse; column name before the trans-all migration: street'), phone
OPTIONS(description='Filial-Telefonnummer; column name before the trans-all migration: phone'), zipcode_postbox
OPTIONS(description='Column name before the trans-all migration: zipcode_postbox'), postbox
OPTIONS(description='Column name before the trans-all migration: postbox'), fax
OPTIONS(description='Column name before the trans-all migration: fax'), modem
OPTIONS(description='Column name before the trans-all migration: modem'), pol_region_sid
OPTIONS(description='''Surrogate identifier of the main administrative reagion in the political country_1
WAWI: WAWI Instance and T008_STORE.C008_EXC_MAIN_REGION'''),
pol_region_cd
OPTIONS(description='''Code of the first level of the administrative hierarchy_1 in the political country_1
WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME'''),
load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'))
OPTIONS(DESCRIPTION = '''contact_1 and address_1 information of stores
WAWI: T008_STORE_1''') AS SELECT st_loc_sid,
 client_id,
 dat_rec_start,
 dat_rec_end,
 zipcode,
 city,
 street,
 phone,
 zipcode_postbox,
 postbox,
 fax,
 modem,
 pol_region_sid,
 pol_region_cd,
 load_id
FROM ldl_p_lew_core.t_wawi_org_store_contact_1;