DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_MSI_DATA.VIS_TAG_UMSATZ_WG_2;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.VIS_TAG_UMSATZ_WG_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_2-DD'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
ABT_ID INTEGER NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
GJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahr'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
WTAG_ID INTEGER NOT NULL OPTIONS(description='Wochentag ID'),
UMS_NETTO NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto'),
UMS_NETTO_AF NUMERIC(29,4) OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_SA NUMERIC(29,4) OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_WVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
UMS_NETTO_AF_WVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_SA_WVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_WVVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
UMS_NETTO_AF_WVVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_SA_WVVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_KVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
UMS_NETTO_AF_KVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_SA_KVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_KVVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
UMS_NETTO_AF_KVVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_NETTO_SA_KVVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
UMS_BRUTTO NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto'),
UMS_BRUTTO_KVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
UMS_BRUTTO_WVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'),
MENGE_ABSATZ NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
MENGE_ABSATZ_AF NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 auf Ebene Markt / TAG_2 / Warengruppe'),
MENGE_ABSATZ_SA NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion auf Ebene Markt / TAG_2 / Warengruppe'),
MENGE_ABSATZ_KVJ NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
MENGE_ABSATZ_AF_KVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
MENGE_ABSATZ_SA_KVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
MENGE_ABSATZ_WVJ NUMERIC(29,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Wochentag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
MENGE_ABSATZ_AF_WVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel_2 des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
MENGE_ABSATZ_SA_WVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel_2 in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / TAG_2 / Warengruppe'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, DAT, NB_ID, WUP_ID, WG_ID, ARTHIERTYP_ID, WRG_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='VIS - Aggregat auf Tagesebene');