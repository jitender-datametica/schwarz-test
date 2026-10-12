CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.SM (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
SM_ID INTEGER NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
SPR_ID INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
SAP_SM_ID STRING(2) COLLATE 'und:ci'
OPTIONS(description='Originalinhalt aus SAP. Für KMO kann die bisherige Regel für die Vergabe der sm_id nicht angewendet werden. Daher erfolgt bei SAP-Char-Formaten eine Umsetzung auf ein numerisches Format'),
SM_BEZ STRING(40) COLLATE 'und:ci' OPTIONS(description='Sortimentsmodul'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (SM_ID, MANDANT_ID, SPR_ID) NOT ENFORCED
)
OPTIONS(description='Sortimentsmodul (=Sortimentsstufe). Inhalt DE: 1,2,3,4,5. Für KMO können auch negative Werte vorkommen');