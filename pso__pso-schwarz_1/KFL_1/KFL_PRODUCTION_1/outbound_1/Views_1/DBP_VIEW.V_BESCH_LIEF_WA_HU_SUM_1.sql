CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_lief_wa_hu_sum_1 (mandant_id OPTIONS(description='Mandant_1 im DWH.'),
handling_unit_id OPTIONS(description='Interne Handling Unit_1 Nummer.'), lief_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
transportation_unit_id OPTIONS(description='Transporteinheit (intern).'), belos_vorgang_id
OPTIONS(description='Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag_1 (Logistikdaten) und einer Sendung (Abrechnungsdaten).'),
wup_id OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), lagernummer_id
OPTIONS(description='Lagernummer / Lagerkomplex.'), versandstelle_id
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_1 Gruppe_1 von Laderampen) oder um eine_1 logische Gruppierung (z.B. eine_1 Gruppe_1 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
lagerort_id
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk / Betrieb eindeutig. Aus lgort.'),
lagersortiment_id OPTIONS(description='Lagersortiment ID.'), diff_id
OPTIONS(description='Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
dat_lief_soll OPTIONS(description='Lieferdatum der Position.'), lief_typ_id
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_1 Lieferung bearbeitet.'),
vertr_beleg_typ_id
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. wurde der Lieferschein aufgrund eines Wareneingangs generiert.'),
arthiertyp_id
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
kunde_id
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine_1 mandant_id_kunde.'),
wg_id OPTIONS(description='ID der Warengruppe.'), wg_verkett_lief
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel_1 gemeinsam auf eine_1 Palette gepackt werden.'),
menge_lief_soll_kolli
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
menge_lief_ist_kolli OPTIONS(description='Ist-Liefermenge in Kolli'), menge_lief_soll_bme
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_ist_bme
OPTIONS(description='Ist-Liefermenge der Lieferposition, ausgedrückt in Bestellmengeneinheit aus lfimg.'),
menge_lief_soll_pal OPTIONS(description='Soll-Liefermenge in Paletten.'), menge_lief_ist_pal
OPTIONS(description='Ist-Liefermenge in Paletten.'), lief_pal_typ_id
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_1 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt).'), anzahl_position
OPTIONS(description='Anzahl der Positionen in der besch_lief_det.'), anzahl_position_charg_split
OPTIONS(description='Anzahl Lieferpositionen (mit Chargensplit).'), anzahl_packstueck_hu
OPTIONS(description='Anzahl Packstücke in Handling Unit.'), anzahl_packstueck_anzpk
OPTIONS(description='Aggregation der Gesamtanzahl der Packstücke für alle Positionen der Lieferung.'), mandant_id_kunde
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als dem der wup_id gehören, z.Bsp. wenn ein Lager aus CZ einen Markt in SK beliefert.'),
werbeware_id
OPTIONS(description='Aus besch_lief_1: Wenn die Bestellart eine_1 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
bestellart_id
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
hu_status_id OPTIONS(description='Bewegungsstatus der Handling Unit.'), brtvol_ladung
OPTIONS(description='Bruttovolumen Ladung.'), brtvol_ladung_gedeckelt
OPTIONS(description='Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet - Deckelung des Volumen der einzelnen HU auf max. 2304 cdm.'),
hu_relevant_fg OPTIONS(description='Flag: HU relevant.'), handling_unit_id_ext_parent
OPTIONS(description='Externe Handling Unit_1 Identifikation aus exidv. Nummer der Versandeinheit (NVE) PARENT.'),
hu_in_beziehung_fg OPTIONS(description='Flag: HU wird von anderer HU als Parent referenziert.'), vol_relevant_fg
OPTIONS(description='Flag: Volumen relevant.'), anzahl_stellplatz_ewm_ext_parent
OPTIONS(description='Anz. Stellpätze (parent HU).'), anzahl_stellplatz_ewm OPTIONS(description='Stellpatzfaktor.'),
handling_unit_id_ext
OPTIONS(description='Externe Handling Unit_1 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
handling_unit_id_parent OPTIONS(description='Übergeordnete Handling Unit.  '), disponent_id
OPTIONS(description='Disponent ID.'), vk_netto_lief_ist
OPTIONS(description='Ist-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
vk_netto_lief_soll
OPTIONS(description='Soll-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
transportsortiment_id
OPTIONS(description='Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)'),
wg_verkett_fg
OPTIONS(description='Flag. Zeigt an, ob eine_1 Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.'),
ntvol_ladung OPTIONS(description='Netto-Ladungsgvolumen der HU.'), ntvol_ladung_gedeckelt
OPTIONS(description='Netto-Ladungsgvolumen der HU (gedeckelt).'), menge_gefahrgut
OPTIONS(description='Menge Gefahrgut.'), wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
brtvol_hu_oa OPTIONS(description='Brutto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette.'), ntvol_hu_oa
OPTIONS(description='Netto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette.'), brtvol_hu_gedeckelt_oa
OPTIONS(description='Brutto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette (gedeckelt auf 2304 cdm).'),
ntvol_hu_gedeckelt_oa
OPTIONS(description='\'Netto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette (gedeckelt auf 2304 cdm).'),
brtgew_hu OPTIONS(description='Brutto-Gewicht der HU.'), ntgew_hu OPTIONS(description='Netto-Gewicht der HU.'),
brtgew_hu_oa OPTIONS(description='Brutto-Gewicht der HU ohne das Volumen der aufgepackten Palette.'), ntgew_hu_oa
OPTIONS(description='Netto-Gewicht der HU ohne das Volumen der aufgepackten Palette.'), menge_lief_ist_kolli_hu
OPTIONS(description='Liefermenge in Kolli auf HU-Ebene.'), auslieferungsgruppe_id
OPTIONS(description='Auslieferungsgruppe aus ZLF_AUSLFEL.'), dat_erstellung
OPTIONS(description='Erstellungsdatum des Lieferbeleges - Quelle: LIKP.ERDAT.'), tms_tour_id
OPTIONS(description='ID des Tours (Tournummer). Eine_1 Tour_1 kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr'),
dat_tour OPTIONS(description='Tourdatum'), tms_system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'))
OPTIONS(DESCRIPTION = `LIS-LOG - FRONTEND DATA MART. WARENAUSGANGS-POSITIONEN AUF EBENE HANDLING UNIT.`) AS SELECT
 mandant_id,
 handling_unit_id,
 lief_beleg_id,
 transportation_unit_id,
 belos_vorgang_id,
 wup_id,
 nb_id,
 lagernummer_id,
 versandstelle_id,
 lagerort_id,
 lagersortiment_id,
 diff_id,
 dat_lief_soll,
 lief_typ_id,
 vertr_beleg_typ_id,
 arthiertyp_id,
 kunde_id,
 wg_id,
 wg_verkett_lief,
 menge_lief_soll_kolli,
 menge_lief_ist_kolli,
 menge_lief_soll_bme,
 menge_lief_ist_bme,
 menge_lief_soll_pal,
 menge_lief_ist_pal,
 lief_pal_typ_id,
 lief_pal_typ_dwh_id,
 anzahl_position,
 anzahl_position_charg_split,
 anzahl_packstueck_hu,
 anzahl_packstueck_anzpk,
 mandant_id_kunde,
 werbeware_id,
 bestellart_id,
 hu_status_id,
 brtvol_ladung,
 brtvol_ladung_gedeckelt,
 hu_relevant_fg,
 handling_unit_id_ext_parent,
 hu_in_beziehung_fg,
 vol_relevant_fg,
 anzahl_stellplatz_ewm_ext_parent,
 anzahl_stellplatz_ewm,
 handling_unit_id_ext,
 handling_unit_id_parent,
 disponent_id,
 vk_netto_lief_ist,
 vk_netto_lief_soll,
 transportsortiment_id,
 wg_verkett_fg,
 ntvol_ladung,
 ntvol_ladung_gedeckelt,
 menge_gefahrgut,
 wrg_id,
 brtvol_hu_oa,
 ntvol_hu_oa,
 brtvol_hu_gedeckelt_oa,
 ntvol_hu_gedeckelt_oa,
 brtgew_hu,
 ntgew_hu,
 brtgew_hu_oa,
 ntgew_hu_oa,
 menge_lief_ist_kolli_hu,
 auslieferungsgruppe_id,
 dat_erstellung,
 tms_tour_id,
 dat_tour,
 tms_system_id
FROM kfl_production_dbp_data.besch_lief_wa_hu_sum_1;