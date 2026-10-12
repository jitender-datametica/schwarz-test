DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_MSI_DATA.VIS_TAG_UMSATZ_KUNDE_WUP;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_MSI_DATA.VIS_TAG_UMSATZ_KUNDE_WUP (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
DAT DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
GJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahr'),
AKT_GJ INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
AKT_MO INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Kalendermonats'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
AKT_WO INTEGER NOT NULL OPTIONS(description='Zähler auf Basis der aktuellen Kalenderwoche'),
WTAG_ID INTEGER NOT NULL OPTIONS(description='Wochentag ID'),
AKT_TAG INTEGER NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Tages'),
UMS_NETTO NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto'),
UMS_NETTO_AF NUMERIC(29,4) OPTIONS(description='Aktionsfreier Netto Umsatz auf Ebene Markt / Tage'),
UMS_NETTO_SA NUMERIC(29,4) OPTIONS(description='Sonderaktion Netto Umsatz auf Ebene Markt / Tag'),
UMS_NETTO_WVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
UMS_NETTO_AF_WVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
UMS_NETTO_SA_WVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
UMS_NETTO_WVVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
UMS_NETTO_AF_WVVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag'),
UMS_NETTO_SA_WVVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des vergleichbaren Wochentages des Vorvorjahres auf Ebene Markt / Tag'),
UMS_NETTO_KVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
UMS_NETTO_AF_KVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
UMS_NETTO_SA_KVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
UMS_NETTO_KVVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
UMS_NETTO_AF_KVVJ NUMERIC(29,4)
OPTIONS(description='Aktionsfreier Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG'),
UMS_NETTO_SA_KVVJ NUMERIC(29,4)
OPTIONS(description='Sonderaktion Netto Umsatz des Kalendertages des Vorvorjahres auf Ebene Markt / TAG'),
UMS_NETTO_PLAN NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz netto Planwert'),
UMS_NETTO_PLAN_EXTERN NUMERIC(29,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz netto Planwert extern'),
UMS_BRUTTO NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto'),
UMS_BRUTTO_WVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz Betrag Brutto Wochentag im Vorjahr'),
UMS_BRUTTO_WVVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Wochentag im Vorvorjahr'),
UMS_BRUTTO_KVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
UMS_BRUTTO_KVVJ NUMERIC(29,4) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vor-Vorjahr'),
ANZ_KUNDE INTEGER NOT NULL OPTIONS(description='Anzahl Kunden'),
ANZ_KUNDE_WVJ INTEGER NOT NULL OPTIONS(description='Anzahl Kunden Wochentag im Vorjahr'),
ANZ_KUNDE_KVJ INTEGER NOT NULL OPTIONS(description='Anzahl Kunden Kalendertag im Vorjahr'),
ANZ_OFFEN INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage'),
ANZ_OFFEN_WVJ INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Wochentag im Vorjahr'),
ANZ_OFFEN_WVVJ INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Wochentag im Vor-Vorjahr'),
ANZ_OFFEN_KVJ INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vorjahr'),
ANZ_OFFEN_KVVJ INTEGER NOT NULL OPTIONS(description='Anzahl Öffnungstage Kalendertag im Vor-Vorjahr'),
MENGE_ABSATZ NUMERIC(29,3) OPTIONS(description='Menge an verkauften Artikel auf Ebene Markt / Tag'),
MENGE_ABSATZ_AF NUMERIC(29,3) OPTIONS(description='Menge an verkauften aktionsfreien Artikel auf Ebene Markt / Tag'),
MENGE_ABSATZ_SA NUMERIC(29,3) OPTIONS(description='Menge an verkauften Artikel in Sonderaktion auf Ebene Markt / Tag'),
MENGE_ABSATZ_WVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
MENGE_ABSATZ_AF_WVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
MENGE_ABSATZ_SA_WVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel in Sonderaktion des vergleichbaren Wochentages des Vorjahres auf Ebene Markt / Tag'),
MENGE_ABSATZ_KVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
MENGE_ABSATZ_AF_KVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften aktionsfreien Artikel des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
MENGE_ABSATZ_SA_KVJ NUMERIC(29,3)
OPTIONS(description='Menge an verkauften Artikel in Sonderaktion des Kalendertages des Vorjahres auf Ebene Markt / Tag'),
MENGE_ABSATZ_OHNE_PFAND_PLAN NUMERIC(29,3)
OPTIONS(description='Geplante Menge an verkauften Artikel ohne Pfandartikel auf Ebene Markt / Tag'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, DAT, NB_ID, WUP_ID, WRG_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='VIS - Aggregat auf Tagesebene - MULTISET - Beladung aus wup_plan_tag');