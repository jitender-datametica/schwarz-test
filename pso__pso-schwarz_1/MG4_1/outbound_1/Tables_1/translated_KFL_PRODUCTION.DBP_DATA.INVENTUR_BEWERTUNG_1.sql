CREATE OR REPLACE TABLE kfl_production_dbp_data.inventur_bewertung_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
inventurart_id INTEGER NOT NULL OPTIONS(description='Inventurart (international nicht identisch)'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
dat_preis DATE NOT NULL
OPTIONS(description='Datum der Inventurbewertung. Das Preisdatum wird benötigt, um die Inventur_1 mit dem zu diesem Zeitpunkt gültigen Preis zu bewerten. Inventurdifferenzen können mehrmals im Jahr bewertet werden.'),
beleg_erfasser_id STRING(20) NOT NULL
OPTIONS(description='ID des Beleg-Erfassers. Kann Batch-Usernamen oder FB enthalten. Aus Datenschutzgründen darf in den Bewegungsdaten nur der Fachbereich des Erfassers abgebildet werden.'),
dat_erstellung DATE NOT NULL OPTIONS(description='Erstelldatum des Datensatzes im Quellsystem.'),
zeit_inventur TIME NOT NULL OPTIONS(description='Uhrzeit der Inventur.'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
owg_id INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_1-Hierarchie-Typ-ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
mwst_id INTEGER NOT NULL OPTIONS(description='Mehrwertsteuersatz-ID (<> Mehrwertsteuersatz!)'),
rate_steuersatz NUMERIC(29,2) NOT NULL OPTIONS(description='Rate des Mehrwertsteuersatzes.'),
inventur_typ_txt STRING(50) NOT NULL
OPTIONS(description='Freitext zur Möglichkeit einer detaillierteren Kategorisierung der Inventurarten.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
menge_bme_inventur_diff NUMERIC(29,3) NOT NULL
OPTIONS(description='Gesamtmenge der ermittelten und verdichteten Inventurdifferenz in Basismengeneinheit auf Ebende Filiale und Artikel.'),
menge_bme_inventur_diebstahl NUMERIC(29,3) NOT NULL
OPTIONS(description='Menge der durch Diebstahl verursachten Inventurdifferenz in Basismengeneinheit auf Ebene Filiale und Artikel.'),
preis_vk_brutto NUMERIC(29,4) NOT NULL
OPTIONS(description='Brutto-Verkaufspreis des Artikels zum Zeitpunkt des Preisdatums.'),
preis_vk_netto NUMERIC(29,4) NOT NULL
OPTIONS(description='Netto-Verkaufspreis des Artikels zum Zeitpunkt des Preisdatums.'),
preis_vk_brutto_korrigiert NUMERIC(29,4) NOT NULL
OPTIONS(description='Korrigierter Brutto-Verkaufspreis des Artikels. Es kann vorkommen, dass dem betrag_vk_brutto Fehler unterliegen. In diesen Fällen kann vom Fachbereich ein korrigierter Betrag angegeben werden. Tritt dieser Fall ein, ist die manuell korrigierte Eingabe führend.'),
betrag_vk_netto_inventur_diff NUMERIC(29,4) NOT NULL
OPTIONS(description='Mit dem Netto-Verkaufspreis bewertete Inventurdifferenz: menge_inventur_diff * betrag_vk_netto'),
betrag_vk_netto_inventur_diebstahl NUMERIC(29,4) NOT NULL
OPTIONS(description='Mit dem Netto Verkaufspreis bewertete durch Diebstahl verursachte Inventurdifferenz: menge_inventur_diebstahl * betrag_vk_netto.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, inventurart_id, wup_id, nb_id, art_id, dat_preis) NOT ENFORCED
)
OPTIONS(description='Tabelle enthält bewertete Inventurdaten auf Ebene Artikel_1 - Filiale. Dazu werden die Positionen in den Materialbelegen auf diese Ebene verdichtet. Dies ist notwendig um verschiedene Besonderheiten abzubilden (bspw. Umzüge, Filialumgliederung, Kleingebindeaufschlag, Treueartikel). Aktuelle Quelltabelle in SAP: ZWWX_INVWERT.');