CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BSCH_RECH_DET_GP_SUM_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
VW_ID INTEGER NOT NULL OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte'),
EK_N NUMERIC(18,4) NOT NULL OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
PRIMARY KEY (MANDANT_ID, DAT, GP_ID, VW_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Aggregat über Wareneingänge pro Lieferant, Tag_2 und Vertriebsweg - MULTISET');