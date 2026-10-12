CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.GP_TEILSORTIMENT_SPR_ZU_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
GP_TEILSORTIMENT_ID STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Teilsortiment aus SAP ltsnr'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
SPR_ID INTEGER NOT NULL OPTIONS(description='Sprache ID'),
GP_TEILSORTIMENT_BEZ STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Kurzbezeichnung aus ltsbz'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, GP_ID, EINKAUFSORGANISATION_ID, SPR_ID) NOT ENFORCED
)
OPTIONS(description='AIS_KMO- Sprachabhängige Bezeichnungen der Teilsortimente pro Lieferant aus der Quelle SAP wyt1t_1');