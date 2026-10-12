CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BSCH_RECH_DET_GP_SUM_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
VW_ID INTEGER NOT NULL OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup_1 Objekte'),
EK_N NUMERIC(18,4) NOT NULL OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, DAT, GP_ID, VW_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Aggregat über Wareneingänge pro Lieferant, Tag_1 und Vertriebsweg - MULTISET');