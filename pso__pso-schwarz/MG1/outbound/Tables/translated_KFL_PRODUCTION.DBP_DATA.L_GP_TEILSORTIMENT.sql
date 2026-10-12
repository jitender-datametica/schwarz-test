CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.L_GP_TEILSORTIMENT (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
GP_TEILSORTIMENT_ID STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Teilsortiment aus SAP ltsnr'),
EINKAUFSORGANISATION_ID INTEGER NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
ZAHLUNGSZIEL_ID STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Zahlungsziel  aus lfm2.zterm'),
ZEK_ID STRING(3) NOT NULL OPTIONS(description='Einkäufergruppe aus lfm2.ekgrp'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, GP_ID, EINKAUFSORGANISATION_ID) NOT ENFORCED
) OPTIONS(description='AIS_KMO- Lookup-Tabelle der Teilsortimente pro Lieferant aus den Quellen SAP wyt1t und lfm2');