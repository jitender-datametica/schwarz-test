CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gfk_hhp_leh_account_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gfk_account_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der GfK-Accounts (wird im DWH manuell erzeutgt auf Basis der gfk_account_bez)'),
gfk_account_bez STRING(120) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der GfK-Accounts (Bsp. Edeka gelb/blau, Rewe, Tengelmann/Kaisers, Famila, Hit ,Kaufland, real,-, Marktkauf, Globus ,Aldi ,Lidl, etc.)'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='EK-INTEGER  - GfK Haushaltspanel Account_2 (z.B. Gesamtmarkt, Kaufland, Rewe, etc.)');