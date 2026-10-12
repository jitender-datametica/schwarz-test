CREATE OR REPLACE VIEW DBP_VIEW.V_ART_WUP_STATUS_PER_1 (
   art_id                                   COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'
  ,mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,wup_id                                   COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,dat_von                                  COMMENT 'Gültigkeitsbeginn des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 01.01.1900 belegt.'
  ,system_id                                COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)'
  ,loesch_id                                COMMENT 'Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch_1 hinterlegt. aus lvorm'
  ,dat_bis                                  COMMENT 'Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.'
  ,wg_verkett_id                            COMMENT 'Kennzeichnung der Warengruppenverkettung eines Artikels Die Warengruppenverkettung gibt an, welche Artikel_1 gemeinsam auf eine_1 Palette gepackt werden. Wird referenziert durch die Tabelle l_wg_verkettung_1'
  ,fremd_lagerort_id                        COMMENT 'Vorschlagslagerort für Fremdbeschaffung. Lagerorte sind in der Tabelle l_lagerort_1 enthalten. Lagerort, zu dem die Ware am Bestimmungsort in einem anderen wup_1 verbracht werden soll.'
  ,disponent_id                             COMMENT 'Disponent-ID aus dem Feld dispo'
  ,pps_plan_kalender_id                     COMMENT 'Id für den Planungskalender - wie oft, an welchen Wochentagen). Gilt auch für den Dispositionsrhythmus.'
  ,disposition_rhythmus_id                  COMMENT 'Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender'
  ,planlieferzeit                           COMMENT 'Planlieferzeit in Tagen'
  ,dispomerkmal                             COMMENT 'Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition aus dismm'
  ,we_bearbeitungszeit                      COMMENT 'Bearbeitungszeit für Wareneingang in Tagen aus webaz'
  ,min_sicherh_bestand                      COMMENT 'Menge, die unterste Grenze für den Sicherheitsbestand angibt. aus eislo'
  ,anliefer_kalender                        COMMENT 'Schlüssel des Anlieferungskalender Kaufland'
  ,kdis                                     COMMENT 'kdis = kein Druck in Sortimentsliste. SAP Quellfeld ZZEK_BZGSVRS Bestellbarkeit eines Artikels. kdis 0: Artikel_1 normal bestellbar, 1:  Artikel_1 wird  zugeteilt'
  ,bezugsweg_id                             COMMENT 'Kennzeichnet, ob der Artikel_1 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'
  ,terminierungsgruppe_1_id                 COMMENT 'LTF: Terminierungsgruppe 1'
  ,terminierungsgruppe_2_id                 COMMENT 'LTF: Terminierungsgruppe 2'
  ,terminierungsgruppe_3_id                 COMMENT 'LTF: Terminierungsgruppe 3'
  ,sollbestand                              COMMENT 'Sollbestand'
  ,dat_loesch_id                            COMMENT 'Feld aus MARC.MMSTD - Datum, ab dem der betriebsspezifische Artikelstatus gültig ist'
  ,selbstabholung_fg                        COMMENT 'MARC.ZLVS_KZSELBSTABH - Kennzeichen Selbstabholung'
  ,min_restlaufzeit                         COMMENT 'Mindestrestlaufzeit in Tagen'
  ,dat_liefersperre_bis                     COMMENT 'Datum, bis zu dem eine_1 Liefersperre für einen bestimmten Artikel_1 oder Lieferanten verhängt wurde. Nach diesem Datum ist der Artikel_1 oder Lieferant wieder für die Lieferung freigegeben.'
  ,ref_wup_id                               COMMENT 'Referenzen für Markt-Artikel_1-Kombinationen finden, die neu sind und für die es daher keine Historie gibt:Ist der Markt neu, gibt es in Spalte VRBWK einen schon existierenden Referenzmarkt.'
  ,rate_ref_absatz                          COMMENT 'Multiplikationsfaktor, mit dem der Absatz der Referenz Markt-Artikel_1-Kombination multipliziert wird für die neue Kombination.Quellfeld ist VRBFK.'
  ,ref_art_id                               COMMENT 'Referenzen für Markt-Artikel_1-Kombinationen finden, die neu sind und für die es daher keine Historie gibt: Ist der Artikel_1 neu, gibt es in Spalte VRBMT einen schon existierenden Referenzartikel.'
  ,dat_ref_gueltig_bis                      COMMENT 'Markiert das Gültigkeitsende (gültig_bis) der Referenz, es gibt kein analoges gültig_von: Die Markt-Artikel_1-Kombination gilt für die gesamte Historie bis zum Datum VRBDT.'
)
COMMENT = 'TP408 LVS - Hier ist der Artikelstatus pro Artikel_1 und Lager hinterlegt. aus SAP MARC_1 - MULTISET'
 AS 
    SELECT 
        art_id,
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

FROM DBP_DATA.ART_WUP_STATUS_PER_1 ;