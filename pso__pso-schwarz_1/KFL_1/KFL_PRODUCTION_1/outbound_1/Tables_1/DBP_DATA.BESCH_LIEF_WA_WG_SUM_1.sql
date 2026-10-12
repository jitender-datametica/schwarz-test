--==============================================================
-- Table: besch_lief_wa_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_wa_wg_sum_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:47 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_wa_wg_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex      '),
versandstelle_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_1 Gruppe_1 von Laderampen) oder um eine_1 logische Gruppierung (z.B. eine_1 Gruppe_1 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
lagersortiment_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagersortiment ID'),
diff_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Lieferdatum der Position'),
lief_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_1 Lieferung bearbeitet.'),
vertr_beleg_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. wurde der Lieferschein aufgrund eines Wareneingangs generiert.'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
kunde_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Als Format wurde bewusst Integer gewählt - ist kein Versehen'),
wg_verkett_lief BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel_1 gemeinsam auf eine_1 Palette gepackt werden.'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_1 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.'),
lief_pal_typ_dwh_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt)'),
mandant_id_kunde BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als der WUP_1 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
werbeware_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Aus besch_lief_1: Wenn die Bestellart eine_1 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
hu_status_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bewegungsstatus der Handling Unit_1'),
disponent_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Disponent ID'),
anzahl_position BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Positionen in der besch_lief_det_1'),
anzahl_position_charg_split BIGNUMERIC(38,0) OPTIONS(description='Anzahl Lieferpositionen (mit Chargensplit)'),
anzahl_packstueck_anzpk BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Aggregation der Gesamtanzahl der Packstücke für alle Positionen der Lieferung'),
anzahl_packstueck_hu BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl Packstück in Handling Unit_1'),
brtvol_ladung NUMERIC(18,3) NOT NULL OPTIONS(description='Bruttovolumen Ladung'),
brtvol_ladung_gedeckelt NUMERIC(18,3) NOT NULL
OPTIONS(description='Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet - Deckelung des Volumen der einzelnen HU auf max. 2304 cdm'),
menge_lief_soll_kolli NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
menge_lief_ist_kolli NUMERIC(18,3) OPTIONS(description='Liefermenge in Kolli'),
menge_lief_soll_bme NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_ist_bme NUMERIC(18,3)
OPTIONS(description='Menge der Lieferposition, ausgedrückt in Verkaufsmengeneinheiten aus lfimg.'),
menge_lief_soll_pal NUMERIC(18,3) OPTIONS(description='Soll-Liefermenge in PAL'),
menge_lief_ist_pal NUMERIC(18,3) OPTIONS(description='Ist-Liefermenge in PAL'),
anzahl_stellplatz_ewm_ext_parent NUMERIC(9,2) OPTIONS(description='Anz. Stellpatz (parent HU)'),
anzahl_stellplatz_ewm NUMERIC(9,2) OPTIONS(description='Stellplatzfaktor'),
vk_netto_lief_ist NUMERIC(18,4)
OPTIONS(description='Liefermenge Ist bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
vk_netto_lief_soll NUMERIC(18,4)
OPTIONS(description='Liefermenge soll bewertet mit dem Verkaufspreis minus MehrWertSteuer. Redundant abgelegt zur Performancesteigerung'),
transportsortiment_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)'),
wg_verkett_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag. Zeigt an, ob eine_1 Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz'),
ntvol_ladung NUMERIC(18,3) OPTIONS(description='Netto-Ladungsgvolumen der HU'),
ntvol_ladung_gedeckelt NUMERIC(18,3) OPTIONS(description='Netto-Ladungsgvolumen der HU (gedeckelt)'),
menge_gefahrgut NUMERIC(7,2) OPTIONS(description='Menge Gefahrgut'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
brtvol_hu_oa NUMERIC(18,3) OPTIONS(description='Brutto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette'),
ntvol_hu_oa NUMERIC(18,3) OPTIONS(description='Netto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette'),
brtvol_hu_gedeckelt_oa NUMERIC(18,3)
OPTIONS(description='Brutto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette (gedeckelt auf 2304 cdm)'),
ntvol_hu_gedeckelt_oa NUMERIC(18,3)
OPTIONS(description='\'Netto-Ladungsvolumen der HU ohne das Volumen der aufgepackten Palette (gedeckelt auf 2304 cdm)'),
brtgew_hu NUMERIC(18,3) OPTIONS(description='Brutto-Gewicht der HU'),
ntgew_hu NUMERIC(18,3) OPTIONS(description='Netto-Gewicht der HU'),
brtgew_hu_oa NUMERIC(18,3) OPTIONS(description='Brutto-Gewicht der HU ohne das Volumen der aufgepackten Palette'),
ntgew_hu_oa NUMERIC(18,3) OPTIONS(description='Netto-Gewicht der HU ohne das Volumen der aufgepackten Palette'),
menge_lief_ist_kolli_hu NUMERIC(18,3) OPTIONS(description='Liefermenge in Kolli auf HU-Ebene'),
auslieferungsgruppe_id STRING(4) OPTIONS(description='Auslieferungsgruppe aus ZLF_AUSLFEL_1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_lief_soll, wg_id, arthiertyp_id, kunde_id, wg_verkett_lief, mandant_id_kunde
 ) NOT ENFORCED
) OPTIONS(description='Warenausgangs-Positionen auf Ebene Warengruppe');