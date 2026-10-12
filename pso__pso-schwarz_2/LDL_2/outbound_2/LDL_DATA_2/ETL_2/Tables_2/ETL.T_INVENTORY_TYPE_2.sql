CREATE TABLE IF NOT EXISTS ldl_data_etl.t_inventory_type_2 (
inv_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the subtype discriminator for inventorys.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
inv_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for inventorys.')
)
OPTIONS(description='This minor entity defines the subtye discriminators for inventorys. It distinguishes between full inventories and partial inventories.');