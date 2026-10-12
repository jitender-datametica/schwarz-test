--==============================================================
-- Table: besch_lief_wg_wup_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_wg_wup_1
   generated from Powerdesigner on Tuesday, April 12, 2022 1:46:27 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_wg_wup_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des VZ'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.'),
diff_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.'),
dat_lief_soll DATE NOT NULL
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.'),
lief_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_1 Lieferung bearbeitet.'),
vertr_beleg_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Kennzeichen liefert die Information aus welchem Vorgang dieser Vertriebsbeleg generiert wurde, z. B. wurde der Lieferschein aufgrund eines Wareneingangs generiert.'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
kunde_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Warenempfänger (Marktnummer)'),
wg_verkett_lief BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Die Warengruppenverkettung gibt an, welche Artikel_1 gemeinsam auf eine_1 Palette gepackt werden.'),
menge_lief_soll_bme NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie ist berechnet (redundante Speicherung) und in Bestellmengeneinheit dargestellt.'),
menge_lief_soll_kolli NUMERIC(18,3)
OPTIONS(description='Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  '),
betrag_lief_soll NUMERIC(18,2) OPTIONS(description='Aggregation betrag_lief_soll aus besch_lief_det_1'),
menge_lief_ist_bme NUMERIC(18,3)
OPTIONS(description='Menge der Lieferposition, ausgedrückt in Verkaufsmengeneinheiten aus lfimg.'),
menge_lief_ist_kolli NUMERIC(18,3)
OPTIONS(description='Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung'),
betrag_lief_ist NUMERIC(18,2) OPTIONS(description='Aggregation betrag_lief_ist aus besch_lief_det_1'),
lief_pal_typ_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='aus der Tabelle besch_lief_1'),
anzahl_position BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Positionen in der besch_lief_det_1'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
mandant_id_kunde BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Der Kunde kann zu einem anderen Mandanten als der WUP_1 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
vk_netto_lief_soll NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Soll-Liefermenge bewertet zum Verkaufspreis minus MehrWertSteuer'),
vk_netto_lief_ist NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Ist-Liefermenge bewertet zum Verkaufspreis minus MehrWertSteuer'),
werbeware_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Aus besch_lief_1: Wenn die Bestellart eine_1 Werbebestellart ist. Wertevorrat: W     Werbung       N      Normalware    B      W und N       S      Schnellschuss'),
bestellart_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
hu_status_id STRING(4) COLLATE 'und:ci' DEFAULT '    ' NOT NULL OPTIONS(description='Bewegungsstatus der Handling Unit_1'),
anzahl_packstueck BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Aggregation der Gesamtanzahl  der Packstücke für alle Positionen der Lieferung'),
brtvol_ladung_liter NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet'),
brtvol_ladung_liter_gedeckelt NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Volumen der Ladung in Litern. Wird aud handling_unit.vol_ladung errechnet - Deckelung des Volumen der einzelnen HU auf max. 2304 cdm'),
auslieferungsgruppe_id STRING(4) OPTIONS(description='Auslieferungsgruppe aus ZLF_AUSLFEL_1'),
ntvol_ladung_liter NUMERIC(18,3) OPTIONS(description='Nettovolumen HU in Liter'),
ntvol_ladung_liter_gedeckelt NUMERIC(18,3) OPTIONS(description='Nettovolumen HU in Liter (gedeckelt)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_lief_soll, wg_id, arthiertyp_id, wg_verkett_lief) NOT ENFORCED
) CLUSTER BY dat_lief_soll
OPTIONS(description='TP408_LVS - Diese Tabelle enthält die nach Warengruppe, Lagerort und Lieferscheintyp  aggregierten Lieferscheine - MULTISET');