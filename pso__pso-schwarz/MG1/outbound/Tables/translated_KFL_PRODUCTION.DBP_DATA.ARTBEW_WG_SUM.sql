DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ARTBEW_WG_SUM;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ARTBEW_WG_SUM (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
DAT DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
KJMO INTEGER NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
UMSATZ_BRUTTO NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz incl. Mehrwertsteuerbetrag\n            '),
UMSATZ_NETTO NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag\n            '),
UMSATZ_WRG STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, in der der Umsatz erzielt wurde, z.Bsp. CZK, EUR'),
UMSATZ_BRUTTO_KONZ NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz brutto in der Konzernwährung'),
UMSATZ_NETTO_KONZ NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz netto in der Konzernwährung'),
QUELLE INTEGER DEFAULT 0,
MENGE NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='ab KW46/12: Hier sind Mengen verschiedener Basismengeneinheiten (Stück und Gewichtsartikel) kumuliert enthalten. Sinnvoll ist das nicht, aber der FB (Vertrieb) will es so.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
UMRECHNUNGSKURS_HIST NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
PRIMARY KEY (MANDANT_ID, NB_ID, ARTHIERTYP_ID, WG_ID, DAT, WUP_ID, BEWART_ID) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='TP1 MIS - Aggregationstabelle artbew auf Ebene Warengruppe/Markt/Datum - MULTISET');