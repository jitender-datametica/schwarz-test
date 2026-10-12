/* --------------------------------------------------------------------------------
   DDL for table: t_item_property_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_PROPERTY_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_property_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key Entity (eindeutig ueber alle Laender/Mandanten hinweg)',
   src_item_property_id                NUMBER(38,0)     COMMENT 'Technical Identifier des Quellsystems WaWi: C236_ID',
   src_atwrt                           VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Technical Identifier des Quellsystems eLWIS: ATWRT',
   item_property_cd                    VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Code fuer das Artikelmerkmal, zB INT_Baby, INT_Fairtrade, INT_MSC; eLWIS: ATWRT WaWi: C236_PROPERTY',
   item_property_int_name              VARCHAR(100)     COLLATE 'en-ci' COMMENT 'International Name des Aritkelmerkmals; WaWi: C236_INT_DESC',
   item_property_local_name            VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Local Name des Aritkelmerkmals; WaWi: C236_LOCAL_DESC',
   item_property_descr                 VARCHAR(1000)    COLLATE 'en-ci' COMMENT 'Ausfuehrliche Beschreibung des Aritkelmerkmals; WaWi: C236_COMMENT',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ITEM_PROPERTY PRIMARY KEY (item_property_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Properties that can be assigned to items, e.g. quality seals or props based on ingredients.
             Set of props is defined on international level as well as country_2 level.
             e.g. vegan, bio, FSC, MSC
             eLWIS: CAWN
             WaWi: T236_item_properties';

