CREATE TABLE DBP_DATA.GFK_HHP_LEH_ACCOUNT_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	GFK_ACCOUNT_ID NUMBER(38,0) NOT NULL COMMENT 'ID der GfK-Accounts (wird im DWH manuell erzeutgt auf Basis der gfk_account_bez)',
	GFK_ACCOUNT_BEZ VARCHAR(120) COLLATE 'en-ci' COMMENT 'Bezeichnung der GfK-Accounts (Bsp. Edeka gelb/blau, Rewe, Tengelmann/Kaisers, Famila, Hit ,Kaufland, real,-, Marktkauf, Globus ,Aldi ,Lidl, etc.)',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - GfK Haushaltspanel Account_2 (z.B. Gesamtmarkt, Kaufland, Rewe, etc.)'
;