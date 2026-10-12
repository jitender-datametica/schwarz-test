CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_GP_SUM (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant'),
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
GP_ID INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)\n            '),
VW_ID INTEGER NOT NULL
OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup Objekte\n            1 = Ost\n            2 = West\n            3 = Nord'),
WRG STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Währung, z.Bsp. EUR'),
UMSATZ_NETTO NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
DIFF_UMSATZ_NETTO_KONZ NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='von der Konzernwährung abweichender Umsatz netto'),
EK_MEP NUMERIC(18,4) NOT NULL OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)'),
DIFF_EK_MEP_KONZ NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='von der Konzernwährung abweichender Einkaufspreis Markteinstandspreis'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
PRIMARY KEY (MANDANT_ID, DAT, GP_ID, VW_ID) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Aggregatstabelle enthält Umsatz und MEP pro Lieferant, Vertriebsweg und Tag - MULTISET');