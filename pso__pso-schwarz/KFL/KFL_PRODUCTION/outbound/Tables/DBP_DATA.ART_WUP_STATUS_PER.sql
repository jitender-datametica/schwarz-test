--==============================================================
-- Table: art_wup_status_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_status_per
   generated from Powerdesigner on Mittwoch, 28. Mai 2025 08:43:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_status_per (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL
OPTIONS(description='Gültigkeitsbeginn des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 01.01.1900 belegt.'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)'),
loesch_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch hinterlegt. aus lvorm'),
dat_bis DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.'),
wg_verkett_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnung der Warengruppenverkettung eines Artikels Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden. Wird referenziert durch die Tabelle l_wg_verkettung'),
fremd_lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Vorschlagslagerort für Fremdbeschaffung. Lagerorte sind in der Tabelle l_lagerort enthalten. Lagerort, zu dem die Ware am Bestimmungsort in einem anderen wup verbracht werden soll.'),
disponent_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Disponent-ID aus dem Feld dispo'),
pps_plan_kalender_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id für den Planungskalender - wie oft, an welchen Wochentagen). Gilt auch für den Dispositionsrhythmus.'),
disposition_rhythmus_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender'),
planlieferzeit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Planlieferzeit in Tagen'),
dispomerkmal STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition aus dismm'),
we_bearbeitungszeit BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bearbeitungszeit für Wareneingang in Tagen aus webaz'),
min_sicherh_bestand NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. aus eislo'),
anliefer_kalender STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel des Anlieferungskalender Kaufland'),
kdis BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='kdis = kein Druck in Sortimentsliste. SAP Quellfeld ZZEK_BZGSVRS Bestellbarkeit eines Artikels. kdis 0: Artikel normal bestellbar, 1:  Artikel wird  zugeteilt'),
bezugsweg_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
terminierungsgruppe_1_id STRING(3) COLLATE 'und:ci' DEFAULT '-1 ' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 1'),
terminierungsgruppe_2_id STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 2'),
terminierungsgruppe_3_id STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 3'),
sollbestand NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Sollbestand'),
dat_loesch_id DATE
OPTIONS(description='Feld aus MARC.MMSTD - Datum, ab dem der betriebsspezifische Artikelstatus gültig ist'),
selbstabholung_fg BIGNUMERIC(38,0) OPTIONS(description='MARC.ZLVS_KZSELBSTABH - Kennzeichen Selbstabholung'),
min_restlaufzeit BIGNUMERIC(38,0) OPTIONS(description='Mindestrestlaufzeit in Tagen'),
dat_liefersperre_bis DATE
OPTIONS(description='Datum, bis zu dem eine Liefersperre für einen bestimmten Artikel oder Lieferanten verhängt wurde. Nach diesem Datum ist der Artikel oder Lieferant wieder für die Lieferung freigegeben.'),
ref_wup_id BIGNUMERIC(38,0)
OPTIONS(description='Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt:Ist der Markt neu, gibt es in Spalte VRBWK einen schon existierenden Referenzmarkt.'),
rate_ref_absatz BIGNUMERIC(38,5) DEFAULT 0
OPTIONS(description='Multiplikationsfaktor, mit dem der Absatz der Referenz Markt-Artikel-Kombination multipliziert wird für die neue Kombination.Quellfeld ist VRBFK.'),
ref_art_id BIGNUMERIC(38,0)
OPTIONS(description='Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt: Ist der Artikel neu, gibt es in Spalte VRBMT einen schon existierenden Referenzartikel.'),
dat_ref_gueltig_bis DATE
OPTIONS(description='Markiert das Gültigkeitsende (gültig_bis) der Referenz, es gibt kein analoges gültig_von: Die Markt-Artikel-Kombination gilt für die gesamte Historie bis zum Datum VRBDT.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='TP408 LVS - Hier ist der Artikelstatus pro Artikel und Lager hinterlegt. aus SAP MARC - MULTISET');