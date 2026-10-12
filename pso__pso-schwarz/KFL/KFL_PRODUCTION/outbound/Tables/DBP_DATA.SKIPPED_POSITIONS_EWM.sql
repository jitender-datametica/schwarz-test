--==============================================================
-- Table: skipped_positions_ewm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: skipped_positions_ewm
   generated from Powerdesigner on Thursday, June 9, 2022 10:14:10 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.skipped_positions_ewm (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='ID der Lagernummer - hoechste Ebene der Lagerhierarchie.'),
lagerauftrag_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lagerauftrag ID.'),
lageraufgabe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lageraufgabe ID.'),
lageraufgabe_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lageraufgabe Position ID.'),
lagersortiment_id STRING(1) OPTIONS(description='Lagersortiment ID.'),
lagerauftrag_status_id STRING(1) OPTIONS(description='Lagerauftrag Status ID.'),
lageraufgabe_status_id STRING(1) OPTIONS(description='Lageraufgabe Status ID.'),
lagerprozessart_id STRING(4) OPTIONS(description='Lagerprozessart ID.'),
artikelsortiment_id STRING(1) OPTIONS(description='Artikelsortiment ID.'),
lief_beleg_id INTEGER
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'),
lief_beleg_pos_id INTEGER
OPTIONS(description='Das Feld enthaelt die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID der eindeutigen Identifikation der Lieferscheinbelegpositionen.'),
lief_pal_typ_id STRING(2)
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.'),
ewm_gv_grp_id STRING(4) OPTIONS(description='Gruppe des Geschaeftsvorfalls.'),
ewm_exc_kategorie_id STRING(1) OPTIONS(description='Exception Kategorie ID (Ebene Lageraufgabe/Position).'),
lagerauftrag_has_exc_1_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Lagerauftrag hat min. eine Lageraufgabe/Position mit Exception Kategorie 1.'),
lagerauftrag_has_exc_2_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Lagerauftrag hat min. eine Lageraufgabe/Position mit Exception Kategorie 2.'),
lagerauftrag_has_exc_3_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Lagerauftrag hat min. eine Lageraufgabe/Position mit Exception Kategorie 3.'),
dat_lief_soll DATE
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschaetzungen errechnen.'),
wg_verkett_lief BIGNUMERIC(38,0)
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel gemeinsam auf eine Palette gepackt werden.'),
werbeware_id STRING(1)
OPTIONS(description='Wird gefuellt, wenn die Bestellart eine Werbebestellart ist. Wertevorrat:            W     Werbung                  N      Normalware               B      W und N                  S      Schnellschuss'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
ausnahme_code STRING(4) OPTIONS(description='Ausnahme-Code.'),
bus_kontext STRING(3) OPTIONS(description='Business Kontext.'),
ausfuehr_schritt_id STRING(2) OPTIONS(description='Ausfuehrungsschritt im Business-Kontext.'),
menge_ist_bme BIGNUMERIC(31,14) OPTIONS(description='Ist-Menge in Basismengeneinheit.'),
manuell_erzeugt_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Manuell erzeugt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagernummer_id, lagerauftrag_id, lageraufgabe_id, lageraufgabe_pos_id) NOT ENFORCED
) OPTIONS(description='EWM Skipped Positions.');