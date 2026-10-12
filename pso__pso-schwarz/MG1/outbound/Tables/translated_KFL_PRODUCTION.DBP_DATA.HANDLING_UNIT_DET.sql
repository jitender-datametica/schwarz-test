DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.HANDLING_UNIT_DET;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.HANDLING_UNIT_DET (
MANDANT_ID INTEGER NOT NULL,
SYSTEM_ID INTEGER NOT NULL,
NB_ID INTEGER NOT NULL,
HANDLING_UNIT_POS_ID INTEGER NOT NULL,
WUP_ID INTEGER NOT NULL,
HANDLING_UNIT_ID INTEGER NOT NULL,
HU_TYP_ID INTEGER,
ANZ_PACK_HILFSMITTEL INTEGER DEFAULT 0,
DE_EGALISIERT_FG INTEGER NOT NULL,
VERP_MENGE_EINH_ID STRING(3),
ART_ID INTEGER,
LAGERORT_ID STRING(4) COLLATE 'und:ci',
MENGE_HANDLING_KOLLI NUMERIC(9,3),
LIEF_BELEG_ID INTEGER,
LIEF_BELEG_POS_ID INTEGER,
KJ_LIEF_BELEG INTEGER,
CHARGE_ID STRING(10) OPTIONS(description='chargennummer           '),
DAT_MHD DATE OPTIONS(description='verfallsdatum oder mindesthaltbarkeitsdatum     '),
HANDLING_UNIT_ID_CHILD INTEGER OPTIONS(description='untergeordnete handling unit       '),
HU_INHALT_IDENT STRING(20) OPTIONS(description='identifikation des handling-unit-inhalts   '),
VERP_MENGE_BME NUMERIC(9,3) OPTIONS(description='verpackte basismenge in der handling unit position '),
TD_UPDATE TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration')
) CLUSTER BY MANDANT_ID;