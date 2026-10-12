/* --------------------------------------------------------------------------------
   DDL for table: t_item_property_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_property_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_property_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key Entity (eindeutig ueber alle Laender/Mandanten hinweg)'),
src_item_property_id BIGNUMERIC(38,0) OPTIONS(description='Technical Identifier des Quellsystems WaWi: C236_ID'),
src_atwrt STRING(50) COLLATE 'und:ci' OPTIONS(description='Technical Identifier des Quellsystems eLWIS: ATWRT'),
item_property_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Code fuer das Artikelmerkmal, zB INT_Baby, INT_Fairtrade, INT_MSC; eLWIS: ATWRT WaWi: C236_PROPERTY'),
item_property_int_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='International Name des Aritkelmerkmals; WaWi: C236_INT_DESC'),
item_property_local_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Local Name des Aritkelmerkmals; WaWi: C236_LOCAL_DESC'),
item_property_descr STRING(1000) COLLATE 'und:ci'
OPTIONS(description='Ausfuehrliche Beschreibung des Aritkelmerkmals; WaWi: C236_COMMENT'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_property_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Properties that can be assigned to items, e.g. quality seals or props based on ingredients.             Set of props is defined on international level as well as country_1 level.             e.g. vegan, bio, FSC, MSC             eLWIS: CAWN             WaWi: T236_item_properties');