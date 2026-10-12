--==============================================================
-- Table: besch_lief_wa_hu_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_wa_hu_sum_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_wa_hu_sum_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
handling_unit_id INTEGER NOT NULL OPTIONS(description='Interne Handling Unit_2 Nummer.'),
lief_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern).'),
belos_vorgang_id BIGNUMERIC(38,0)
OPTIONS(description='Im DWH generierte eindeutige ID für die Belos Vorgänge. Ein Belos Vorgang setzt sich aus einem Transportauftrag_2 (Logistikdaten) und einer Sendung (Abrechnungsdaten).'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer / Lagerkomplex.'),
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_2 Gruppe_2 von Laderampen) oder um eine_2 logische Gruppierung (z.B. eine_2 Gruppe_2 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk / Betrieb eindeutig. Aus lgort.'),
lagersortiment_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagersortiment ID.'),
diff_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wenn eine_2 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Lieferdatum der Position.'),
lief_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_2 Lieferung bearbeitet.'),
vertr_beleg_typ_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. wurde der Lieferschein aufgrund eines Wareneingangs generiert.'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen handelt.'),
kunde_id BIGNUMERIC(38,0)
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine_2 mandant_id_kunde.'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe.'),
wg_verkett_lief BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel_2 gemeinsam auf eine_2 Palette gepackt werden.'),
menge_lief_soll_kolli NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
menge_lief_ist_kolli NUMERIC(18,3) OPTIONS(description='Ist-Liefermenge in Kolli'),
menge_lief_soll_bme NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_ist_bme NUMERIC(18,3)
OPTIONS(description='Ist-Liefermenge der Lieferposition, ausgedrückt in Bestellmengeneinheit aus lfimg.'),
menge_lief_soll_pal NUMERIC(18,3) OPTIONS(description='Soll-Liefermenge in Paletten.'),
menge_lief_ist_pal NUMERIC(18,3) OPTIONS(description='Ist-Liefermenge in Paletten.'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_2 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt).'),
anzahl_position BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Positionen in der besch_lief_det.'),
anzahl_position_charg_split BIGNUMERIC(38,0) OPTIONS(description='Anzahl Lieferpositionen (mit Chargensplit).'),
anzahl_packstueck_hu BIGNUMERIC(38,0) OPTIONS(description='Anzahl Packstücke in Handling Unit.'),
anzahl_packstueck_anzpk BIGNUMERIC(38,0)
OPTIONS(description='Aggregation der Gesamtanzahl der Packstücke für alle Positionen der Lieferung.'),
mandant_id_kunde BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als dem der wup_id gehören, z.Bsp. wenn ein Lager aus CZ einen Markt in SK beliefert.'),
werbeware_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Aus besch_lief_2: Wenn die Bestellart eine_2 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
hu_status_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bewegungsstatus der Handling Unit.'),
brtvol_ladung NUMERIC(18,3) NOT NULL OPTIONS(description='Bruttovolumen Ladung.'),
brtvol_ladung_gedeckelt NUMERIC(18,3) NOT NULL
OPTIONS(description='Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet - Deckelung des Volumen der einzelnen HU auf max. 2304 cdm.'),
hu_relevant_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: HU relevant.'),
handling_unit_id_ext_parent STRING(200) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_2 Identifikation aus exidv. Nummer der Versandeinheit (NVE) PARENT.'),
hu_in_beziehung_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: HU wird von anderer HU als Parent referenziert.'),
vol_relevant_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Volumen relevant.'),
anzahl_stellplatz_ewm_ext_parent NUMERIC(9,2) OPTIONS(description='Anz. Stellpätze (parent HU).'),
anzahl_stellplatz_ewm NUMERIC(9,2) OPTIONS(description='Stellpatzfaktor.'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_2 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
handling_unit_id_parent INTEGER OPTIONS(description='Übergeordnete Handling Unit.  '),
disponent_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Disponent ID.'),
vk_netto_lief_ist NUMERIC(18,4)
OPTIONS(description='Ist-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
vk_netto_lief_soll NUMERIC(18,4)
OPTIONS(description='Soll-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
transportsortiment_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)'),
wg_verkett_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag. Zeigt an, ob eine_2 Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.'),
ntvol_ladung NUMERIC(18,3) OPTIONS(description='Netto-Ladungsgvolumen der HU.'),
ntvol_ladung_gedeckelt NUMERIC(18,3) OPTIONS(description='Netto-Ladungsgvolumen der HU (gedeckelt).'),
menge_gefahrgut NUMERIC(7,2) OPTIONS(description='Menge Gefahrgut.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
brtvol_hu_oa NUMERIC(18,3)
OPTIONS(description='Brutto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette.'),
ntvol_hu_oa NUMERIC(18,3) OPTIONS(description='Netto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette.'),
brtvol_hu_gedeckelt_oa NUMERIC(18,3)
OPTIONS(description='Brutto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette (gedeckelt auf 2304 cdm).'),
ntvol_hu_gedeckelt_oa NUMERIC(18,3)
OPTIONS(description='\'Netto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette (gedeckelt auf 2304 cdm).'),
brtgew_hu NUMERIC(18,3) OPTIONS(description='Brutto-Gewicht der HU.'),
ntgew_hu NUMERIC(18,3) OPTIONS(description='Netto-Gewicht der HU.'),
brtgew_hu_oa NUMERIC(18,3) OPTIONS(description='Brutto-Gewicht der HU ohne das Volumen der aufgepackten Palette.'),
ntgew_hu_oa NUMERIC(18,3) OPTIONS(description='Netto-Gewicht der HU ohne das Volumen der aufgepackten Palette.'),
menge_lief_ist_kolli_hu NUMERIC(18,3) OPTIONS(description='Liefermenge in Kolli auf HU-Ebene.'),
auslieferungsgruppe_id STRING(4) OPTIONS(description='Auslieferungsgruppe aus ZLF_AUSLFEL.'),
dat_erstellung DATE OPTIONS(description='Erstellungsdatum des Lieferbeleges - Quelle: LIKP.ERDAT.'),
tms_tour_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Tours (Tournummer). Eine_2 Tour_2 kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr'),
dat_tour DATE OPTIONS(description='Tourdatum'),
tms_system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, handling_unit_id, lief_beleg_id) NOT ENFORCED
) OPTIONS(description='LIS-LOG - Frontend Data Mart. Warenausgangs-Positionen auf Ebene Handling Unit.');