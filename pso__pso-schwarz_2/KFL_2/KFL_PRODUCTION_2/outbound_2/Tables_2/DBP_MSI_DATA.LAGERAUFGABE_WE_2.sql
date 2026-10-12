--==============================================================
-- Table: lageraufgabe_we_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lageraufgabe_we_2
   generated from Powerdesigner on Samstag, 18. Oktober 2025 06:19:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.lageraufgabe_we_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
lageraufgabe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lageraufgabe_2'),
lageraufgabe_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lageraufgabenposition'),
best_beleg_id STRING(35) NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'),
lief_beleg_id BIGNUMERIC(35,0) NOT NULL
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. '),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit '),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Transporteinheit  transportation_unit_sr_act_id '),
transportation_unit_id_ext STRING(20) OPTIONS(description='Transporteinheit (extern)'),
lagerprozessart_id STRING(4) OPTIONS(description='Lagerprozessart'),
status_id STRING(1) OPTIONS(description='Lageraufgabenstatus'),
lagerprozess_id STRING(4) OPTIONS(description='Lagerungsprozess'),
zz_colli_qty BIGNUMERIC(38,0) OPTIONS(description='Kollimenge (zz_colli_qty)'),
menge_kolli BIGNUMERIC(38,0) OPTIONS(description='Kollimenge (berechnet)'),
menge_pal NUMERIC(15,3) OPTIONS(description='Palettenmenge'),
lagerbereich_id_nach STRING(4) OPTIONS(description='Nachlagerbereich'),
lagertyp_id_nach STRING(4) OPTIONS(description='Nach-Lagertyp'),
le_typ_id STRING(4) OPTIONS(description='Handling-Unit_2-Typ'),
gewicht_netto NUMERIC(15,3) OPTIONS(description='Ladungs- / Nettogewicht'),
gewicht_brutto BIGNUMERIC(38,3)
OPTIONS(description='Bruttogewicht der jeweiligen Wareneingangs-Position. Es beinhaltet das Gewicht der Ladung.'),
gew_einh_id STRING(3) OPTIONS(description='Gewichtseinheit'),
volumen NUMERIC(15,3) OPTIONS(description='Ladungs- oder Nettovolumen'),
vol_einh_id STRING(3) OPTIONS(description='Volumeneinheit'),
dat_mhd DATE OPTIONS(description='Best-Before Date / Shelf Life Expiration Date'),
datzeit_we TIMESTAMP OPTIONS(description='Datum und Uhrzeit des Wareneingangs'),
dat_we DATE OPTIONS(description='Datum und Uhrzeit des Wareneingangs'),
datzeit_erstellung TIMESTAMP OPTIONS(description='Erstellungszeitpunkt'),
dat_erstellung DATE OPTIONS(description='Erstellungszeitpunkt'),
handling_unit_id_nach STRING(20) OPTIONS(description='Nach-Handling-Unit_2'),
handling_unit_guid_nach STRING(32) OPTIONS(description='eindeutige interne Identifikation einer Handling Unit_2'),
handling_unit_id_von STRING(20) OPTIONS(description='Von-Handling-Unit_2'),
handling_unit_guid_von STRING(32) OPTIONS(description='eindeutige interne Identifikation einer Handling Unit_2'),
bestandsart_id STRING(2) OPTIONS(description='Bestandsart'),
charge_id STRING(10) OPTIONS(description='Charge'),
gefahrstoff_fg BIGNUMERIC(38,0) OPTIONS(description='Gefahrstoff'),
aktivitaetsbereich_id STRING(4) OPTIONS(description='Aktivitätsbereich'),
art_guid STRING(32) OPTIONS(description='Product'),
menge_ist_bme BIGNUMERIC(31,14) OPTIONS(description='Istmenge in Basismengeneinheit'),
menge_ist_ame BIGNUMERIC(31,14) OPTIONS(description='Istmenge in alternativer Mengeneinheit'),
rollback_fg BIGNUMERIC(38,0) OPTIONS(description='Lageraufgabe_2'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
queue_id STRING(10) OPTIONS(description='Queue'),
datzeit_bestaetigung TIMESTAMP OPTIONS(description='Bestätigungszeit in Lagerzeitzone'),
dat_bestaetigung DATE NOT NULL OPTIONS(description='Erstelldatum der Bestätigung'),
lagertyp_id_von STRING(4) OPTIONS(description='Von-Lagertyp'),
artikelsortiment_id STRING(1) OPTIONS(description='Kauflandspezifische Info Sortiments ID'),
lagersortiment_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Lagersortiment ID.'),
distanz_reserve_fixplatz NUMERIC(13,3) OPTIONS(description='TDC Reserve zu Fixplatz'),
distanz_bsf_reserve NUMERIC(13,3) OPTIONS(description='TDC BSF zu Reserve'),
distanz_hoehe NUMERIC(13,3) OPTIONS(description='TDC Höhenaufschlag'),
handling_unit_id_nach_fixplatz STRING(20)
OPTIONS(description='ID der Handling Unit_2 (z. B. Palette) auf die sich die Distanz zum Fixplatz bezieht'),
handling_unit_id_nach_bsf STRING(20)
OPTIONS(description='ID der Handling Unit_2 (z. B. Palette) auf die sich die Distanz zur BSF bezieht'),
handling_unit_id_nach_hoehe STRING(20)
OPTIONS(description='ID der Handling Unit_2 (z. B. Palette) auf die sich der Höhenaufschlag bezieht'),
lagertyp_id_nach_distanz STRING(4) OPTIONS(description='Nach-Lagertyp abhängig vom Prozess'),
lagerplatz_id_nach_distanz STRING(18) OPTIONS(description='Nach-Lagerplatz abhängig vom Prozess'),
lagerplatz_id_nach STRING(18) COLLATE 'und:ci' OPTIONS(description='Nachlagerplatz'),
lagerplatz_id_von STRING(18) COLLATE 'und:ci' OPTIONS(description='Vonlagerplatz'),
selbstabhol_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Flag kennzeichnet die Selbstaholung dieser Position, Wert 1 entspricht selbstabgeholt.Aus klvs_kzselbstabh'),
lageraufgabe_orig_fg BIGNUMERIC(38,0)
OPTIONS(description='Markiert den jew. ersten Datensatz pro Lageraufgabe_2, sodass bei > 1 Zeile Kennzahlen nicht verdoppelt werden (Multiplikation Kennzahl*Flag in Frontend-MV).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagernummer_id, lageraufgabe_id, lageraufgabe_pos_id, best_beleg_id, lief_beleg_id)
NOT ENFORCED
) OPTIONS(description='Wareneingangs-Positionen (Zusammenführung Lieferung+Bestellung+Handling Unit_2)');