--==============================================================
-- Table: besch_lief_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_det
   generated from Powerdesigner on Mittwoch, 21. April 2021 16:34:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_det (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
lief_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
lief_beleg_pos_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID  der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
menge_lief_ist_bme NUMERIC(18,3)
OPTIONS(description='Menge der Lieferposition, ausgedrückt in Verkaufsmengeneinheiten aus lfimg.'),
vorlage_beleg_id INTEGER NOT NULL
OPTIONS(description='Dieses Feld enthält die Nummer des Vorlagebeleges. (referenzierte Belegart noch unbekannt).'),
vorlage_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dieses Feld  enthält die Nummer der Position des Vorlagebeleges. (referenzierte Belegart noch unbekannt)'),
diff_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wenn eine Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
menge_lief_soll_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
bruttogew NUMERIC(18,3) NOT NULL
OPTIONS(description='Bruttogesamtgewicht aller Positionen der Lieferung. Das Bruttogewicht setzt sich aus dem Nettogewicht und dem Gewicht der Verpackung zusammen.'),
verk_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant und Artikel eine alternative Mengeneinheit eindeutig identifiziert.Aus meinh'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.'),
menge_kolli NUMERIC(18,3) NOT NULL
OPTIONS(description='Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per ermittelt.'),
menge_lief_palette NUMERIC(18,3)
OPTIONS(description='Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per und art_umrechnung_faktor_per ermittelt.'),
annahmeverweigerung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Dieses Attribut enthält die Gründe für die Annahmeverweigerung. Referenz zu der DWH Tabelle l_annahmeverweigerung'),
dat_haltbarkeit DATE OPTIONS(description='Dieses Feld enthält das Mindesthaltbarkeitsdatum.'),
dat_aenderung DATE NOT NULL
OPTIONS(description='Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen)'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellpositionen. (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen) '),
dat_lief_soll DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance'),
menge_lief_soll_bme NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_ist_kolli NUMERIC(18,3)
OPTIONS(description='Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung'),
betrag_lief_ist NUMERIC(18,4)
OPTIONS(description='redundantes Feld, um den CROSS JOIN zur art_gp_wup_zu_per zu sparen, berechnet anzahl_kolli*ek_netto_bnk*komponentenmenge.'),
betrag_lief_soll NUMERIC(18,4)
OPTIONS(description='redundantes Feld, um den CROSS JOIN zur art_gp_wup_zu_per zu sparen, berechnet menge_lief_soll*ek_netto_bnk*komponentenmenge.'),
menge_lief_ist_lme NUMERIC(18,3) DEFAULT 0.000 NOT NULL
OPTIONS(description='tatsächlich gelieferte Menge in Lagermengeneinheiten.'),
system_id BIGNUMERIC(38,0) DEFAULT 7 NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
aktions_pos_kz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Kennzeichen Aktionsposition. Aktionspositionen sind mit X gekennzeichnet. Aus zzlvaktpos'),
besch_palette_fg BIGNUMERIC(38,0)
OPTIONS(description='Ist gleich 1, wenn die Bestellung in Paletten erfolgte. Denormalisierung von besch_best_det.best_baismenge_einh_id'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
vk_netto_lief_soll NUMERIC(18,4) DEFAULT 0.0000 NOT NULL
OPTIONS(description='Liefermenge soll bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
vk_netto_lief_ist NUMERIC(18,4) DEFAULT 0.0000 NOT NULL
OPTIONS(description='Liefermenge Ist bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
bestellart_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
charge_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Charge'),
uebg_chargensplit_pos BIGNUMERIC(38,0) OPTIONS(description='Übergeordnete Position der Chargensplitposition'),
menge_lief_soll_orig NUMERIC(18,3) OPTIONS(description='Originale Soll-Liefermenge'),
ausnahmecode_mengendiff STRING(4) OPTIONS(description='Ausnahmecode Lager fuer Mengendifferenz'),
dat_art_bereitstellung DATE OPTIONS(description='Artikelbereitstellungsdatum'),
lief_pos_typ_id STRING(4) OPTIONS(description='Positionstyp Lieferung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) CLUSTER BY mandant_id, dat_lief_soll
OPTIONS(description='TP408 LVS - In dieser Tabelle sind die Belegpositionen der Lieferscheine aus der SAP Tabelle LIPS enthalten - MULTISET. Die dazugehörigen Kopfdaten befinden sich in der DWH Tabelle besch_lief - MULTISET');