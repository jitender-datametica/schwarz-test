--==============================================================
-- Table: art_wup_status_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_status_per
   generated from Powerdesigner on Mittwoch, 28. Mai 2025 08:43:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_STATUS_PER CLUSTER BY (MANDANT_ID) (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitsbeginn des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 01.01.1900 belegt.',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)',
   loesch_id                           VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch hinterlegt. aus lvorm',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.',
   wg_verkett_id                       INTEGER     NOT NULL COMMENT 'Kennzeichnung der Warengruppenverkettung eines Artikels Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden. Wird referenziert durch die Tabelle l_wg_verkettung',
   fremd_lagerort_id                   VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Vorschlagslagerort für Fremdbeschaffung. Lagerorte sind in der Tabelle l_lagerort enthalten. Lagerort, zu dem die Ware am Bestimmungsort in einem anderen wup verbracht werden soll.',
   disponent_id                        VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Disponent-ID aus dem Feld dispo',
   pps_plan_kalender_id                VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Id für den Planungskalender - wie oft, an welchen Wochentagen). Gilt auch für den Dispositionsrhythmus.',
   disposition_rhythmus_id             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender',
   planlieferzeit                      INTEGER     NOT NULL COMMENT 'Planlieferzeit in Tagen',
   dispomerkmal                        VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition aus dismm',
   we_bearbeitungszeit                 INTEGER     NOT NULL COMMENT 'Bearbeitungszeit für Wareneingang in Tagen aus webaz',
   min_sicherh_bestand                 NUMBER(29,3)     NOT NULL COMMENT 'Menge, die unterste Grenze für den Sicherheitsbestand angibt. aus eislo',
   anliefer_kalender                   VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel des Anlieferungskalender Kaufland',
   kdis                                INTEGER     NOT NULL DEFAULT -1 COMMENT 'kdis = kein Druck in Sortimentsliste. SAP Quellfeld ZZEK_BZGSVRS Bestellbarkeit eines Artikels. kdis 0: Artikel normal bestellbar, 1:  Artikel wird  zugeteilt',
   bezugsweg_id                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
   terminierungsgruppe_1_id            VARCHAR(3)       NOT NULL COLLATE 'en-ci' DEFAULT '-1 ' COMMENT 'LTF: Terminierungsgruppe 1',
   terminierungsgruppe_2_id            VARCHAR(2)       NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'LTF: Terminierungsgruppe 2',
   terminierungsgruppe_3_id            VARCHAR(2)       NOT NULL COLLATE 'en-ci' DEFAULT '-1' COMMENT 'LTF: Terminierungsgruppe 3',
   sollbestand                         NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Sollbestand',
   dat_loesch_id                       DATE             COMMENT 'Feld aus MARC.MMSTD - Datum, ab dem der betriebsspezifische Artikelstatus gültig ist',
   selbstabholung_fg                   INTEGER     COMMENT 'MARC.ZLVS_KZSELBSTABH - Kennzeichen Selbstabholung',
   min_restlaufzeit                    INTEGER     COMMENT 'Mindestrestlaufzeit in Tagen',
   dat_liefersperre_bis                DATE             COMMENT 'Datum, bis zu dem eine Liefersperre für einen bestimmten Artikel oder Lieferanten verhängt wurde. Nach diesem Datum ist der Artikel oder Lieferant wieder für die Lieferung freigegeben.',
   ref_wup_id                          INTEGER     COMMENT 'Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt:Ist der Markt neu, gibt es in Spalte VRBWK einen schon existierenden Referenzmarkt.',
   rate_ref_absatz                     NUMBER(29,5)     DEFAULT 0 COMMENT 'Multiplikationsfaktor, mit dem der Absatz der Referenz Markt-Artikel-Kombination multipliziert wird für die neue Kombination.Quellfeld ist VRBFK.',
   ref_art_id                          INTEGER     COMMENT 'Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt: Ist der Artikel neu, gibt es in Spalte VRBMT einen schon existierenden Referenzartikel.',
   dat_ref_gueltig_bis                 DATE             COMMENT 'Markiert das Gültigkeitsende (gültig_bis) der Referenz, es gibt kein analoges gültig_von: Die Markt-Artikel-Kombination gilt für die gesamte Historie bis zum Datum VRBDT.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_STATUS_PER PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP408 LVS - Hier ist der Artikelstatus pro Artikel und Lager hinterlegt. aus SAP MARC - MULTISET';
