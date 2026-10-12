CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.INVENTUR_BEWERTUNG_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
INVENTURART_ID INTEGER NOT NULL OPTIONS(description='Inventurart (international nicht identisch)'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
DAT_PREIS DATE NOT NULL
OPTIONS(description='Datum der Inventurbewertung. Das Preisdatum wird benötigt, um die Inventur_2 mit dem zu diesem Zeitpunkt gültigen Preis zu bewerten. Inventurdifferenzen können mehrmals im Jahr bewertet werden.'),
BELEG_ERFASSER_ID STRING(20) NOT NULL
OPTIONS(description='ID des Beleg-Erfassers. Kann Batch-Usernamen oder FB enthalten. Aus Datenschutzgründen darf in den Bewegungsdaten nur der Fachbereich des Erfassers abgebildet werden.'),
DAT_ERSTELLUNG DATE NOT NULL OPTIONS(description='Erstelldatum des Datensatzes im Quellsystem.'),
ZEIT_INVENTUR TIME NOT NULL OPTIONS(description='Uhrzeit der Inventur.'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
OWG_ID INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2-Hierarchie-Typ-ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
MWST_ID INTEGER NOT NULL OPTIONS(description='Mehrwertsteuersatz-ID (<> Mehrwertsteuersatz!)'),
RATE_STEUERSATZ NUMERIC(29,2) NOT NULL OPTIONS(description='Rate des Mehrwertsteuersatzes.'),
INVENTUR_TYP_TXT STRING(50) NOT NULL
OPTIONS(description='Freitext zur Möglichkeit einer detaillierteren Kategorisierung der Inventurarten.'),
WRG_ID STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
MENGE_BME_INVENTUR_DIFF NUMERIC(29,3) NOT NULL
OPTIONS(description='Gesamtmenge der ermittelten und verdichteten Inventurdifferenz in Basismengeneinheit auf Ebende Filiale und Artikel.'),
MENGE_BME_INVENTUR_DIEBSTAHL NUMERIC(29,3) NOT NULL
OPTIONS(description='Menge der durch Diebstahl verursachten Inventurdifferenz in Basismengeneinheit auf Ebene Filiale und Artikel.'),
PREIS_VK_BRUTTO NUMERIC(29,4) NOT NULL
OPTIONS(description='Brutto-Verkaufspreis des Artikels zum Zeitpunkt des Preisdatums.'),
PREIS_VK_NETTO NUMERIC(29,4) NOT NULL
OPTIONS(description='Netto-Verkaufspreis des Artikels zum Zeitpunkt des Preisdatums.'),
PREIS_VK_BRUTTO_KORRIGIERT NUMERIC(29,4) NOT NULL
OPTIONS(description='Korrigierter Brutto-Verkaufspreis des Artikels. Es kann vorkommen, dass dem betrag_vk_brutto Fehler unterliegen. In diesen Fällen kann vom Fachbereich ein korrigierter Betrag angegeben werden. Tritt dieser Fall ein, ist die manuell korrigierte Eingabe führend.'),
BETRAG_VK_NETTO_INVENTUR_DIFF NUMERIC(29,4) NOT NULL
OPTIONS(description='Mit dem Netto-Verkaufspreis bewertete Inventurdifferenz: menge_inventur_diff * betrag_vk_netto'),
BETRAG_VK_NETTO_INVENTUR_DIEBSTAHL NUMERIC(29,4) NOT NULL
OPTIONS(description='Mit dem Netto Verkaufspreis bewertete durch Diebstahl verursachte Inventurdifferenz: menge_inventur_diebstahl * betrag_vk_netto.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, INVENTURART_ID, WUP_ID, NB_ID, ART_ID, DAT_PREIS) NOT ENFORCED
)
OPTIONS(description='Tabelle enthält bewertete Inventurdaten auf Ebene Artikel_2 - Filiale. Dazu werden die Positionen in den Materialbelegen auf diese Ebene verdichtet. Dies ist notwendig um verschiedene Besonderheiten abzubilden (bspw. Umzüge, Filialumgliederung, Kleingebindeaufschlag, Treueartikel). Aktuelle Quelltabelle in SAP: ZWWX_INVWERT.');