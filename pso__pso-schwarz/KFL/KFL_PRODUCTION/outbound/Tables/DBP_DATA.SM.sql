--==============================================================
-- Table: sm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sm
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:54:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sm (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
sm_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
sap_sm_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Originalinhalt aus SAP. Für KMO kann die bisherige Regel für die Vergabe der sm_id nicht angewendet werden. Daher erfolgt bei SAP-Char-Formaten eine Umsetzung auf ein numerisches Format'),
sm_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sortimentsmodul'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (sm_id, mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Sortimentsmodul (=Sortimentsstufe). Inhalt DE: 1,2,3,4,5. Für KMO können auch negative Werte vorkommen');