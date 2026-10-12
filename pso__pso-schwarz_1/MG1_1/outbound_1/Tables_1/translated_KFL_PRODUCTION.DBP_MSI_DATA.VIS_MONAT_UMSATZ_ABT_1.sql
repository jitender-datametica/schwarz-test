CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.VIS_MONAT_UMSATZ_ABT_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
ABT_ID INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
GJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahr'),
AKT_GJ INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'),
AKT_MO INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 0, der vorige Monat_1 -1 und der nächste Monat_1 den Wert 1'),
MO_KJ INTEGER NOT NULL
OPTIONS(description='Laufender Monat_1 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
UMS_NETTO NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto'),
UMS_NETTO_KVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
UMS_NETTO_KVVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
UMS_NETTO_PLAN NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Planwert'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, KJMO, ABT_ID, ARTHIERTYP_ID) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat auf Monatsebene - MULTISET');