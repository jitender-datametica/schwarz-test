DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.ART_WUP_STATUS_PER;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_STATUS_PER (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
NB_ID INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
DAT_VON DATE NOT NULL
OPTIONS(description='Gültigkeitsbeginn des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 01.01.1900 belegt.'),
SYSTEM_ID INTEGER NOT NULL OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)'),
LOESCH_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch hinterlegt. aus lvorm'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.'),
WG_VERKETT_ID INTEGER NOT NULL
OPTIONS(description='Kennzeichnung der Warengruppenverkettung eines Artikels Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden. Wird referenziert durch die Tabelle l_wg_verkettung'),
FREMD_LAGERORT_ID STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Vorschlagslagerort für Fremdbeschaffung. Lagerorte sind in der Tabelle l_lagerort enthalten. Lagerort, zu dem die Ware am Bestimmungsort in einem anderen wup verbracht werden soll.'),
DISPONENT_ID STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Disponent-ID aus dem Feld dispo'),
PPS_PLAN_KALENDER_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id für den Planungskalender - wie oft, an welchen Wochentagen). Gilt auch für den Dispositionsrhythmus.'),
DISPOSITION_RHYTHMUS_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender'),
PLANLIEFERZEIT INTEGER NOT NULL OPTIONS(description='Planlieferzeit in Tagen'),
DISPOMERKMAL STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition aus dismm'),
WE_BEARBEITUNGSZEIT INTEGER NOT NULL OPTIONS(description='Bearbeitungszeit für Wareneingang in Tagen aus webaz'),
MIN_SICHERH_BESTAND NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. aus eislo'),
ANLIEFER_KALENDER STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel des Anlieferungskalender Kaufland'),
KDIS INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='kdis = kein Druck in Sortimentsliste. SAP Quellfeld ZZEK_BZGSVRS Bestellbarkeit eines Artikels. kdis 0: Artikel normal bestellbar, 1:  Artikel wird  zugeteilt'),
BEZUGSWEG_ID INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
TERMINIERUNGSGRUPPE_1_ID STRING(3) COLLATE 'und:ci' DEFAULT '-1 ' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 1'),
TERMINIERUNGSGRUPPE_2_ID STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 2'),
TERMINIERUNGSGRUPPE_3_ID STRING(2) COLLATE 'und:ci' DEFAULT '-1' NOT NULL
OPTIONS(description='LTF: Terminierungsgruppe 3'),
SOLLBESTAND NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Sollbestand'),
DAT_LOESCH_ID DATE
OPTIONS(description='Feld aus MARC.MMSTD - Datum, ab dem der betriebsspezifische Artikelstatus gültig ist'),
SELBSTABHOLUNG_FG INTEGER OPTIONS(description='MARC.ZLVS_KZSELBSTABH - Kennzeichen Selbstabholung'),
MIN_RESTLAUFZEIT INTEGER OPTIONS(description='Mindestrestlaufzeit in Tagen'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
DAT_LIEFERSPERRE_BIS DATE
OPTIONS(description='Datum, bis zu dem eine Liefersperre für einen bestimmten Artikel oder Lieferanten verhängt wurde. Nach diesem Datum ist der Artikel oder Lieferant wieder für die Lieferung freigegeben.'),
REF_WUP_ID INTEGER
OPTIONS(description='Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt:Ist der Markt neu, gibt es in Spalte VRBWK einen schon existierenden Referenzmarkt.'),
RATE_REF_ABSATZ NUMERIC(29,5) DEFAULT 0
OPTIONS(description='Multiplikationsfaktor, mit dem der Absatz der Referenz Markt-Artikel-Kombination multipliziert wird für die neue Kombination.Quellfeld ist VRBFK.'),
REF_ART_ID INTEGER
OPTIONS(description='Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt: Ist der Artikel neu, gibt es in Spalte VRBMT einen schon existierenden Referenzartikel.'),
DAT_REF_GUELTIG_BIS DATE
OPTIONS(description='Markiert das Gültigkeitsende (gültig_bis) der Referenz, es gibt kein analoges gültig_von: Die Markt-Artikel-Kombination gilt für die gesamte Historie bis zum Datum VRBDT.'),
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT_VON) NOT ENFORCED
) CLUSTER BY MANDANT_ID
OPTIONS(description='TP408 LVS - Hier ist der Artikelstatus pro Artikel und Lager hinterlegt. aus SAP MARC - MULTISET');