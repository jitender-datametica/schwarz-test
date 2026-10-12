CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAWI_ORG_STORE_CONTACT_2 (
   st_loc_sid                               COMMENT 'Surrogate Key der Filiale; column name before the trans-all migration: st_loc_sid'
  ,client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT;column name before the trans-all migration: client_id'
  ,dat_rec_start                            COMMENT 'Gültigkeitsdatum von; column name before the trans-all migration: dat_rec_start'
  ,dat_rec_end                              COMMENT 'Gültigkeitsdatum bis; column name before the trans-all migration: dat_rec_end'
  ,zipcode                                  COMMENT 'Filial-Postleitzahl; column name before the trans-all migration: zipcode'
  ,city                                     COMMENT 'Filial-Ort; column name before the trans-all migration: city'
  ,street                                   COMMENT 'Filial-Adresse; column name before the trans-all migration: street'
  ,phone                                    COMMENT 'Filial-Telefonnummer; column name before the trans-all migration: phone'
  ,zipcode_postbox                          COMMENT 'Column name before the trans-all migration: zipcode_postbox'
  ,postbox                                  COMMENT 'Column name before the trans-all migration: postbox'
  ,fax                                      COMMENT 'Column name before the trans-all migration: fax'
  ,modem                                    COMMENT 'Column name before the trans-all migration: modem'
  ,pol_region_sid                           COMMENT 'Surrogate identifier of the main administrative reagion in the political country_2
WAWI: WAWI Instance and T008_STORE.C008_EXC_MAIN_REGION'
  ,pol_region_cd                            COMMENT 'Code of the first level of the administrative hierarchy_2 in the political country_2
WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME'
  ,load_id                                  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'
)
COMMENT = 'contact_2 and address_2 information of stores
WAWI: T008_STORE_2'
AS SELECT
   st_loc_sid
  ,client_id
  ,dat_rec_start
  ,dat_rec_end
  ,zipcode
  ,city
  ,street
  ,phone
  ,zipcode_postbox
  ,postbox
  ,fax
  ,modem
  ,pol_region_sid
  ,pol_region_cd
  ,load_id
FROM P_LEW_CORE.T_WAWI_ORG_STORE_CONTACT_2
;