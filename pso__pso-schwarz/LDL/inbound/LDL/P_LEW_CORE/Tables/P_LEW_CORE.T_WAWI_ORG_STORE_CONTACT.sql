/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_org_store_contact
   generated from Powerdesigner on Montag, 29. Januar 2024 10:35:39
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_WAWI_ORG_STORE_CONTACT (
   st_loc_sid                          NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key der Filiale; column name before the trans-all migration: st_loc_sid',
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT;column name before the trans-all migration: client_id',
   dat_rec_start                       DATE            NOT NULL COMMENT 'Gültigkeitsdatum von; column name before the trans-all migration: dat_rec_start',
   dat_rec_end                         DATE            NOT NULL COMMENT 'Gültigkeitsdatum bis; column name before the trans-all migration: dat_rec_end',
   zipcode                             VARCHAR(15)     COLLATE 'en-ci' COMMENT 'Filial-Postleitzahl; column name before the trans-all migration: zipcode',
   city                                VARCHAR(100)    COLLATE 'en-ci' COMMENT 'Filial-Ort; column name before the trans-all migration: city',
   street                              VARCHAR(70)     COLLATE 'en-ci' COMMENT 'Filial-Adresse; column name before the trans-all migration: street',
   phone                               VARCHAR(50)     COLLATE 'en-ci' COMMENT 'Filial-Telefonnummer; column name before the trans-all migration: phone',
   zipcode_postbox                     VARCHAR(15)     COLLATE 'en-ci' COMMENT 'Column name before the trans-all migration: zipcode_postbox',
   postbox                             VARCHAR(50)     COLLATE 'en-ci' COMMENT 'Column name before the trans-all migration: postbox',
   fax                                 VARCHAR(35)     COLLATE 'en-ci' COMMENT 'Column name before the trans-all migration: fax',
   modem                               VARCHAR(50)     COLLATE 'en-ci' COMMENT 'Column name before the trans-all migration: modem',
   pol_region_sid                      NUMBER(38,0)    COMMENT 'Surrogate identifier of the main administrative reagion in the political country
            WAWI: WAWI Instance and T008_STORE.C008_EXC_MAIN_REGION',
   pol_region_cd                       VARCHAR(100)    COMMENT 'Code of the first level of the administrative hierarchy in the political country
            WAWI: T1302_MAIN_REGION.C1302_SHORT_NAME',
   load_id                             NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id',   
   CONSTRAINT PK_T_WAWI_ORG_STORE_CONTACT PRIMARY KEY (st_loc_sid, dat_rec_start) NOT ENFORCED 
)  COMMENT = 'contact and address information of stores
             WAWI: T008_STORE';
