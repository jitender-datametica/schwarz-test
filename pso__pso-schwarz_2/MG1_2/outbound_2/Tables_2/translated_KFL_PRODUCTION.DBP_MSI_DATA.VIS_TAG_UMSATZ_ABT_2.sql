DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_MSI_DATA.VIS_TAG_UMSATZ_ABT_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.VIS_TAG_UMSATZ_ABT_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_2-DD'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
ABT_ID INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
UMS_NETTO NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto'),
UMS_NETTO_WVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
UMS_NETTO_WVVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
UMS_NETTO_KVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
UMS_NETTO_KVVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, DAT, NB_ID, WUP_ID, ARTHIERTYP_ID, ABT_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='VIS - Aggregat auf Tagesebene - MULTISET');