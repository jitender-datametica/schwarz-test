CREATE OR REPLACE VIEW kfl_production_dbp_view.v_besch_lief_wa_det (mandant_id OPTIONS(description='Mandant im DWH.'),
lief_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
lief_beleg_pos_id
OPTIONS(description='Das Feld enthält die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
handling_unit_id OPTIONS(description='Interne Handling Unit Nummer.'), handling_unit_pos_id
OPTIONS(description='Handling Unit Position.'), hu_typ_id
OPTIONS(description='Der Typ des Handling Unit Positionsinhalts 1 ist immer die Ware, damit kann man Ladungsträger und Ladehilfsmittel ausschließen.'),
best_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'),
transportation_unit_id OPTIONS(description='Transporteinheit (intern).'), belos_vorgang_id
OPTIONS(description='Referenz zum Belos-Vorgang. Nicht in jedem Fall vorhanden. Defaultwert ist 0.'), wup_id
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), lagernummer_id
OPTIONS(description='Lagernummer / Lagerkomplex.'), versandstelle_id
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine Gruppe von Laderampen) oder um eine logische Gruppierung (z.B. eine Gruppe von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
lagerort_id
OPTIONS(description='Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk / Betrieb eindeutig. Aus lgort.'),
lagersortiment_id OPTIONS(description='Lagersortiment ID.'), diff_id
OPTIONS(description='Wenn eine Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
dat_lief_soll OPTIONS(description='Lieferdatum der Position.'), lief_typ_id
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine Lieferung bearbeitet.'),
vertr_beleg_typ_id
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. wurde der Lieferschein aufgrund eines Wareneingangs generiert.'),
art_id OPTIONS(description='Artikelnummer.'), kunde_id
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine mandant_id_kunde.'),
wg_verkett_lief
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden.'),
menge_lief_soll_kolli
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
menge_lief_ist_kolli OPTIONS(description='Ist-Liefermenge in Kolli.'), menge_lief_soll_bme
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_ist_bme
OPTIONS(description='Ist-Liefermenge der Lieferposition, ausgedrückt in Bestellmengeneinheit aus lfimg.'),
menge_lief_soll_pal OPTIONS(description='Soll-Liefermenge in Paletten.'), menge_lief_ist_pal
OPTIONS(description='Ist-Liefermenge in Paletten.'), lief_pal_typ_id
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt),'), mandant_id_kunde
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als dem der wup_id gehören, z.B. wenn ein Lager aus CZ einen Markt in SK beliefert.'),
werbeware_id
OPTIONS(description='Aus besch_lief: Wird gefüllt, wenn die Bestellart eine Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
bestellart_id
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
hu_status_id OPTIONS(description='Bewegungsstatus der Handling Unit.'), handling_unit_id_ext_parent
OPTIONS(description='Externe Handling Unit Identifikation aus exidv. Nummer der Versandeinheit (NVE) PARENT.'),
handling_unit_id_ext
OPTIONS(description='Externe Handling Unit Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
handling_unit_id_parent OPTIONS(description='Übergeordnete Handling Unit.'), originalposition_lief_fg
OPTIONS(description='Kennzeichen Orginalposition.'), position_charg_split_fg
OPTIONS(description='Position mit Chargensplit.'), disponent_id OPTIONS(description='Disponent ID.'), dat_haltbarkeit
OPTIONS(description='Dieses Feld enthält das Mindesthaltbarkeitsdatum.'), charge_id OPTIONS(description='Charge ID.'),
anzahl_packstueck OPTIONS(description='Anzahl von Packstücken.'), vk_netto_lief_ist
OPTIONS(description='Ist-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
vk_netto_lief_soll
OPTIONS(description='Soll-Liefermenge, bewertet mit dem Verkaufspreis, minus Mehrwertsteuer. Redundant abgelegt zur Performancesteigerung.'),
transportsortiment_id
OPTIONS(description='Transportsortiment ID - concatenation of  Lagersortiment IDs that should be put on the same truck for transportation (for example 27 means Lagersortiment ID 2 and Lagersortiment ID 7 are transported together)'),
split_lief_kennz
OPTIONS(description='Kennzeichen Split-Lieferung: leer = keine Splitlieferung, O = Orginalposition, S = Split-Position.'),
lief_beleg_id_orig OPTIONS(description='Orginal-Lieferbeleg zu Split-Lieferpositionen.'), wg_verkett_fg
OPTIONS(description='Flag. Zeigt an, ob eine Warengruppenverkettung existiert. Aus dem Feld zzlvwgrvkhier_kz.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'), uebg_chargensplit_pos
OPTIONS(description='Übergeordnete Position der Chargensplitposition.'), auslieferungsgruppe_id
OPTIONS(description='Auslieferungsgruppe aus ZLF_AUSLFEL.'), dat_erstellung
OPTIONS(description='Erstellungsdatum des Lieferbeleges - Quelle: LIKP.ERDAT.'), tms_tour_id
OPTIONS(description='ID des Tours (Tournummer). Eine Tour kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr'),
dat_tour OPTIONS(description='Tourdatum'), tms_system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.')) AS SELECT mandant_id,
 lief_beleg_id,
 lief_beleg_pos_id,
 handling_unit_id,
 handling_unit_pos_id,
 hu_typ_id,
 best_beleg_id,
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
 art_id,
 kunde_id,
 wg_verkett_lief,
 menge_lief_soll_kolli,
 menge_lief_ist_kolli,
 menge_lief_soll_bme,
 menge_lief_ist_bme,
 menge_lief_soll_pal,
 menge_lief_ist_pal,
 lief_pal_typ_id,
 lief_pal_typ_dwh_id,
 mandant_id_kunde,
 werbeware_id,
 bestellart_id,
 hu_status_id,
 handling_unit_id_ext_parent,
 handling_unit_id_ext,
 handling_unit_id_parent,
 originalposition_lief_fg,
 position_charg_split_fg,
 disponent_id,
 dat_haltbarkeit,
 charge_id,
 anzahl_packstueck,
 vk_netto_lief_ist,
 vk_netto_lief_soll,
 transportsortiment_id,
 split_lief_kennz,
 lief_beleg_id_orig,
 wg_verkett_fg,
 wrg_id,
 uebg_chargensplit_pos,
 auslieferungsgruppe_id,
 dat_erstellung,
 tms_tour_id,
 dat_tour,
 tms_system_id
FROM kfl_production_dbp_data.besch_lief_wa_det;