CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.VIS_MONAT_UMSATZ_WG_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
WRG_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
ABT_ID INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
GJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahr'),
UMS_NETTO NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto'),
UMS_NETTO_KVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
UMS_NETTO_KVVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
UMS_NETTO_PLAN NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz netto Planwert'),
UMS_BRUTTO NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz brutto'),
UMS_BRUTTO_KVJ NUMERIC(29,2) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
MENGE_ABSATZ NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
MENGE_ABSATZ_KVJ NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
MENGE_ABSATZ_KVVJ NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vor-Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, KJMO, ARTHIERTYP_ID, WG_ID) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat auf Monatsebene - MULTISET');