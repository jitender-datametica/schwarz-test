DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.BESCH_LIEF_DET_1;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BESCH_LIEF_DET_1 (
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
LIEF_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
LIEF_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
KJ INTEGER NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
MENGE_LIEF_IST_BME NUMERIC(18,3)
OPTIONS(description='Menge der Lieferposition, ausgedrückt in Verkaufsmengeneinheiten aus lfimg.'),
VORLAGE_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Dieses Feld enthält die Nummer des Vorlagebeleges. (referenzierte Belegart noch unbekannt).'),
VORLAGE_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Dieses Feld  enthält die Nummer der Position des Vorlagebeleges. (referenzierte Belegart noch unbekannt)'),
DIFF_ID STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
MENGE_LIEF_SOLL_KOLLI NUMERIC(18,3) NOT NULL
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
BRUTTOGEW NUMERIC(18,3) NOT NULL
OPTIONS(description='Bruttogesamtgewicht aller Positionen der Lieferung. Das Bruttogewicht setzt sich aus dem Nettogewicht und dem Gewicht der Verpackung zusammen.'),
VERK_MENGE_EINH_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_1 und Artikel_1 eine_1 alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
LAGERORT_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.'),
MENGE_KOLLI NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_1 ermittelt.'),
MENGE_LIEF_PALETTE NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_1 und art_umrechnung_faktor_per_1 ermittelt.'),
ANNAHMEVERWEIGERUNG_ID INTEGER NOT NULL
OPTIONS(description='Dieses Attribut enthält die Gründe für die Annahmeverweigerung. Referenz zu der DWH Tabelle l_annahmeverweigerung_1'),
DAT_HALTBARKEIT DATE OPTIONS(description='Dieses Feld enthält das Mindesthaltbarkeitsdatum.'),
DAT_AENDERUNG DATE NOT NULL
OPTIONS(description='Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.'),
BEST_BELEG_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen)'),
BEST_BELEG_POS_ID INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellpositionen. (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen) '),
DAT_LIEF_SOLL DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen. Das Feld wird aus der Kopftabelle\"vererbt\", um einen PPI darüber bilden zu können (Performance'),
MENGE_LIEF_SOLL_BME NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
MENGE_LIEF_IST_KOLLI NUMERIC(18,3)
OPTIONS(description='Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung'),
BETRAG_LIEF_IST NUMERIC(18,4)
OPTIONS(description='redundantes Feld, um den CROSS JOIN zur art_gp_wup_zu_per_1 zu sparen, berechnet anzahl_kolli*ek_netto_bnk*komponentenmenge.'),
BETRAG_LIEF_SOLL NUMERIC(18,4)
OPTIONS(description='redundantes Feld, um den CROSS JOIN zur art_gp_wup_zu_per_1 zu sparen, berechnet menge_lief_soll*ek_netto_bnk*komponentenmenge.'),
MENGE_LIEF_IST_LME NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='tatsächlich gelieferte Menge in Lagermengeneinheiten.'),
SYSTEM_ID INTEGER DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
AKTIONS_POS_KZ STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Kennzeichen Aktionsposition. Aktionspositionen sind mit X gekennzeichnet. Aus zzlvaktpos'),
BESCH_PALETTE_FG INTEGER
OPTIONS(description='Ist gleich 1, wenn die Bestellung in Paletten erfolgte. Denormalisierung von besch_best_det.best_baismenge_einh_id'),
WRG_ID STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
VK_NETTO_LIEF_SOLL NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Liefermenge soll bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
VK_NETTO_LIEF_IST NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Liefermenge Ist bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
BESTELLART_ID STRING(4) COLLATE 'und:ci'
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
CHARGE_ID STRING(10) COLLATE 'und:ci' OPTIONS(description='Charge'),
UEBG_CHARGENSPLIT_POS INTEGER OPTIONS(description='Übergeordnete Position der Chargensplitposition'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
MENGE_LIEF_SOLL_ORIG NUMERIC(18,3) OPTIONS(description='Originale Soll-Liefermenge'),
AUSNAHMECODE_MENGENDIFF STRING(4) OPTIONS(description='Ausnahmecode Lager fuer Mengendifferenz'),
DAT_ART_BEREITSTELLUNG DATE OPTIONS(description='Artikelbereitstellungsdatum'),
LIEF_POS_TYP_ID STRING(4) OPTIONS(description='Positionstyp Lieferung')
) CLUSTER BY MANDANT_ID, DAT_LIEF_SOLL
OPTIONS(description='TP408 LVS - In dieser Tabelle sind die Belegpositionen der Lieferscheine aus der SAP Tabelle LIPS enthalten - MULTISET. Die dazugehörigen Kopfdaten befinden sich in der DWH Tabelle besch_lief_1 - MULTISET');