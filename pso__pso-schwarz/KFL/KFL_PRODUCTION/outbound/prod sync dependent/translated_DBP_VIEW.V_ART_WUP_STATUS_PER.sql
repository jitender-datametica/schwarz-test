CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_status_per (art_id
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
mandant_id OPTIONS(description='Mandant im DWH'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat_von
OPTIONS(description='Gültigkeitsbeginn des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 01.01.1900 belegt.'),
system_id OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)'), loesch_id
OPTIONS(description='Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch hinterlegt. aus lvorm'),
dat_bis
OPTIONS(description='Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.'),
wg_verkett_id
OPTIONS(description='Kennzeichnung der Warengruppenverkettung eines Artikels Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden. Wird referenziert durch die Tabelle l_wg_verkettung'),
fremd_lagerort_id
OPTIONS(description='Vorschlagslagerort für Fremdbeschaffung. Lagerorte sind in der Tabelle l_lagerort enthalten. Lagerort, zu dem die Ware am Bestimmungsort in einem anderen wup verbracht werden soll.'),
disponent_id OPTIONS(description='Disponent-ID aus dem Feld dispo'), pps_plan_kalender_id
OPTIONS(description='Id für den Planungskalender - wie oft, an welchen Wochentagen). Gilt auch für den Dispositionsrhythmus.'),
disposition_rhythmus_id
OPTIONS(description='Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender'),
planlieferzeit OPTIONS(description='Planlieferzeit in Tagen'), dispomerkmal
OPTIONS(description='Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition aus dismm'),
we_bearbeitungszeit OPTIONS(description='Bearbeitungszeit für Wareneingang in Tagen aus webaz'), min_sicherh_bestand
OPTIONS(description='Menge, die unterste Grenze für den Sicherheitsbestand angibt. aus eislo'), anliefer_kalender
OPTIONS(description='Schlüssel des Anlieferungskalender Kaufland'), kdis
OPTIONS(description='kdis = kein Druck in Sortimentsliste. SAP Quellfeld ZZEK_BZGSVRS Bestellbarkeit eines Artikels. kdis 0: Artikel normal bestellbar, 1:  Artikel wird  zugeteilt'),
bezugsweg_id
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
terminierungsgruppe_1_id OPTIONS(description='LTF: Terminierungsgruppe 1'), terminierungsgruppe_2_id
OPTIONS(description='LTF: Terminierungsgruppe 2'), terminierungsgruppe_3_id
OPTIONS(description='LTF: Terminierungsgruppe 3'), sollbestand OPTIONS(description='Sollbestand'), dat_loesch_id
OPTIONS(description='Feld aus MARC.MMSTD - Datum, ab dem der betriebsspezifische Artikelstatus gültig ist'),
selbstabholung_fg OPTIONS(description='MARC.ZLVS_KZSELBSTABH - Kennzeichen Selbstabholung'), min_restlaufzeit
OPTIONS(description='Mindestrestlaufzeit in Tagen'), dat_liefersperre_bis
OPTIONS(description='Datum, bis zu dem eine Liefersperre für einen bestimmten Artikel oder Lieferanten verhängt wurde. Nach diesem Datum ist der Artikel oder Lieferant wieder für die Lieferung freigegeben.'),
ref_wup_id
OPTIONS(description='Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt:Ist der Markt neu, gibt es in Spalte VRBWK einen schon existierenden Referenzmarkt.'),
rate_ref_absatz
OPTIONS(description='Multiplikationsfaktor, mit dem der Absatz der Referenz Markt-Artikel-Kombination multipliziert wird für die neue Kombination.Quellfeld ist VRBFK.'),
ref_art_id
OPTIONS(description='Referenzen für Markt-Artikel-Kombinationen finden, die neu sind und für die es daher keine Historie gibt: Ist der Artikel neu, gibt es in Spalte VRBMT einen schon existierenden Referenzartikel.'),
dat_ref_gueltig_bis
OPTIONS(description='Markiert das Gültigkeitsende (gültig_bis) der Referenz, es gibt kein analoges gültig_von: Die Markt-Artikel-Kombination gilt für die gesamte Historie bis zum Datum VRBDT.'))
OPTIONS(DESCRIPTION = `TP408 LVS - Hier ist der Artikelstatus pro Artikel und Lager hinterlegt. aus SAP MARC - MULTISET`)
AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_von,
 system_id,
 loesch_id,
 dat_bis,
 wg_verkett_id,
 fremd_lagerort_id,
 disponent_id,
 pps_plan_kalender_id,
 disposition_rhythmus_id,
 planlieferzeit,
 dispomerkmal,
 we_bearbeitungszeit,
 min_sicherh_bestand,
 anliefer_kalender,
 kdis,
 bezugsweg_id,
 terminierungsgruppe_1_id,
 terminierungsgruppe_2_id,
 terminierungsgruppe_3_id,
 sollbestand,
 dat_loesch_id,
 selbstabholung_fg,
 min_restlaufzeit,
 dat_liefersperre_bis,
 ref_wup_id,
 rate_ref_absatz,
 ref_art_id,
 dat_ref_gueltig_bis
FROM kfl_production_dbp_data.art_wup_status_per;