--==============================================================
-- Table: besch_lief_wa_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_wa_det_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_wa_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
lief_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
lief_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
handling_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Interne Handling Unit_2 Nummer.'),
handling_unit_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Handling Unit_2 Position.'),
hu_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Typ des Handling Unit_2 Positionsinhalts 1 ist immer die Ware, damit kann man Ladungsträger und Ladehilfsmittel ausschließen.'),
best_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern).'),
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Referenz zum Belos-Vorgang. Nicht in jedem Fall vorhanden. Defaultwert ist 0.'),
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
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer.'),
kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine_2 mandant_id_kunde.'),
wg_verkett_lief BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel_2 gemeinsam auf eine_2 Palette gepackt werden.'),
menge_lief_soll_kolli NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
menge_lief_ist_kolli NUMERIC(18,3) OPTIONS(description='Ist-Liefermenge in Kolli.'),
menge_lief_soll_bme NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_ist_bme NUMERIC(18,3)
OPTIONS(description='Ist-Liefermenge der Lieferposition, ausgedrückt in Bestellmengeneinheit aus lfimg.'),
menge_lief_soll_pal NUMERIC(18,3) OPTIONS(description='Soll-Liefermenge in Paletten.'),
menge_lief_ist_pal NUMERIC(18,3) OPTIONS(description='Ist-Liefermenge in Paletten.'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_2 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt),'),
mandant_id_kunde BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als dem der wup_id gehören, z.B. wenn ein Lager aus CZ einen Markt in SK beliefert.'),
werbeware_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Aus besch_lief_2: Wird gefüllt, wenn die Bestellart eine_2 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
hu_status_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bewegungsstatus der Handling Unit.'),
handling_unit_id_ext_parent STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_2 Identifikation aus exidv. Nummer der Versandeinheit (NVE) PARENT.'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_2 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
handling_unit_id_parent INTEGER OPTIONS(description='Übergeordnete Handling Unit.'),
originalposition_lief_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kennzeichen Orginalposition.'),
position_charg_split_fg BIGNUMERIC(38,0) OPTIONS(description='Position mit Chargensplit.'),
disponent_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Disponent ID.'),
dat_haltbarkeit DATE OPTIONS(description='Dieses Feld enthält das Mindesthaltbarkeitsdatum.'),
charge_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Charge ID.'),
anzahl_packstueck BIGNUMERIC(38,0) OPTIONS(description='Anzahl von Packstücken.'),
vk_netto_lief_ist NUMERIC(18,4)
OPTIONS(description='Ist-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
vk_netto_lief_soll NUMERIC(18,4)
OPTIONS(description='Soll-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
transportsortiment_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)'),
split_lief_kennz STRING(1)
OPTIONS(description='Kennzeichen Split-Lieferung: leer = keine Splitlieferung, O = Orginalposition, S = Split-Position.'),
lief_beleg_id_orig INTEGER OPTIONS(description='Orginal-Lieferbeleg zu Split-Lieferpositionen.'),
wg_verkett_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag. Zeigt an, ob eine_2 Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
uebg_chargensplit_pos BIGNUMERIC(38,0) OPTIONS(description='Übergeordnete Position der Chargensplitposition.'),
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
PRIMARY KEY (mandant_id, lief_beleg_id, lief_beleg_pos_id, handling_unit_id, handling_unit_pos_id, best_beleg_id)
NOT ENFORCED
)
OPTIONS(description='LIS-LOG - Frontend Data Mart. Warenausgangs-Positionen (Zusammenführung Lieferung + Bestellung + Handling Unit_2).');