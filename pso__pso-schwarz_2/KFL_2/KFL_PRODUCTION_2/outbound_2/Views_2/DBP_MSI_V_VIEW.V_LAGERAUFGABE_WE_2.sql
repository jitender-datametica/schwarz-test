CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_lageraufgabe_we_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id OPTIONS(description='Lagernummer/Lagerkomplex'), lageraufgabe_id OPTIONS(description='Lageraufgabe_2'),
lageraufgabe_pos_id OPTIONS(description='Lageraufgabenposition'), best_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'),
lief_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. '),
transportation_unit_id OPTIONS(description='Transporteinheit '), kj_transportation_unit
OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='Transporteinheit  transportation_unit_sr_act_id '), transportation_unit_id_ext
OPTIONS(description='Transporteinheit (extern)'), lagerprozessart_id OPTIONS(description='Lagerprozessart'), status_id
OPTIONS(description='Lageraufgabenstatus'), lagerprozess_id OPTIONS(description='Lagerungsprozess'), zz_colli_qty
OPTIONS(description='Kollimenge (zz_colli_qty)'), menge_kolli OPTIONS(description='Kollimenge (berechnet)'), menge_pal
OPTIONS(description='Palettenmenge'), lagerbereich_id_nach OPTIONS(description='Nachlagerbereich'), lagertyp_id_nach
OPTIONS(description='Nach-Lagertyp'), le_typ_id OPTIONS(description='Handling-Unit_2-Typ'), gewicht_netto
OPTIONS(description='Ladungs- / Nettogewicht'), gewicht_brutto
OPTIONS(description='Bruttogewicht der jeweiligen Wareneingangs-Position. Es beinhaltet das Gewicht der Ladung.'),
gew_einh_id OPTIONS(description='Gewichtseinheit'), volumen OPTIONS(description='Ladungs- oder Nettovolumen'),
vol_einh_id OPTIONS(description='Volumeneinheit'), dat_mhd
OPTIONS(description='Best-Before Date / Shelf Life Expiration Date'), datzeit_we
OPTIONS(description='Datum und Uhrzeit des Wareneingangs'), dat_we
OPTIONS(description='Datum und Uhrzeit des Wareneingangs'), datzeit_erstellung
OPTIONS(description='Erstellungszeitpunkt'), dat_erstellung OPTIONS(description='Erstellungszeitpunkt'),
handling_unit_id_nach OPTIONS(description='Nach-Handling-Unit_2'), handling_unit_guid_nach
OPTIONS(description='eindeutige interne Identifikation einer Handling Unit_2'), handling_unit_id_von
OPTIONS(description='Von-Handling-Unit_2'), handling_unit_guid_von
OPTIONS(description='eindeutige interne Identifikation einer Handling Unit_2'), bestandsart_id
OPTIONS(description='Bestandsart'), charge_id OPTIONS(description='Charge'), gefahrstoff_fg
OPTIONS(description='Gefahrstoff'), aktivitaetsbereich_id OPTIONS(description='Aktivitätsbereich'), art_guid
OPTIONS(description='Product'), menge_ist_bme OPTIONS(description='Istmenge in Basismengeneinheit'), menge_ist_ame
OPTIONS(description='Istmenge in alternativer Mengeneinheit'), rollback_fg OPTIONS(description='Lageraufgabe_2'), art_id
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), queue_id OPTIONS(description='Queue'),
datzeit_bestaetigung OPTIONS(description='Bestätigungszeit in Lagerzeitzone'), dat_bestaetigung
OPTIONS(description='Erstelldatum der Bestätigung'), lagertyp_id_von OPTIONS(description='Von-Lagertyp'),
artikelsortiment_id OPTIONS(description='Kauflandspezifische Info Sortiments ID'), lagersortiment_id
OPTIONS(description='Lagersortiment ID.'), distanz_reserve_fixplatz OPTIONS(description='TDC Reserve zu Fixplatz'),
distanz_bsf_reserve OPTIONS(description='TDC BSF zu Reserve'), distanz_hoehe OPTIONS(description='TDC Höhenaufschlag'),
handling_unit_id_nach_fixplatz
OPTIONS(description='ID der Handling Unit_2 (z. B. Palette) auf die sich die Distanz zum Fixplatz bezieht'),
handling_unit_id_nach_bsf
OPTIONS(description='ID der Handling Unit_2 (z. B. Palette) auf die sich die Distanz zur BSF bezieht'),
handling_unit_id_nach_hoehe
OPTIONS(description='ID der Handling Unit_2 (z. B. Palette) auf die sich der Höhenaufschlag bezieht'),
lagertyp_id_nach_distanz OPTIONS(description='Nach-Lagertyp abhängig vom Prozess'), lagerplatz_id_nach_distanz
OPTIONS(description='Nach-Lagerplatz abhängig vom Prozess'), lagerplatz_id_nach OPTIONS(description='Nachlagerplatz'),
lagerplatz_id_von OPTIONS(description='Vonlagerplatz'), selbstabhol_fg
OPTIONS(description='Das Flag kennzeichnet die Selbstaholung dieser Position, Wert 1 entspricht selbstabgeholt.Aus klvs_kzselbstabh'),
lageraufgabe_orig_fg
OPTIONS(description='Markiert den jew. ersten Datensatz pro Lageraufgabe_2, sodass bei > 1 Zeile Kennzahlen nicht verdoppelt werden (Multiplikation Kennzahl*Flag in Frontend-MV).'))
OPTIONS(DESCRIPTION = `WARENEINGANGS-POSITIONEN (ZUSAMMENFÜHRUNG LIEFERUNG+BESTELLUNG+HANDLING UNIT_2)`) AS SELECT
 mandant_id,
 lagernummer_id,
 lageraufgabe_id,
 lageraufgabe_pos_id,
 best_beleg_id,
 lief_beleg_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 transportation_unit_id_ext,
 lagerprozessart_id,
 status_id,
 lagerprozess_id,
 zz_colli_qty,
 menge_kolli,
 menge_pal,
 lagerbereich_id_nach,
 lagertyp_id_nach,
 le_typ_id,
 gewicht_netto,
 gewicht_brutto,
 gew_einh_id,
 volumen,
 vol_einh_id,
 dat_mhd,
 datzeit_we,
 dat_we,
 datzeit_erstellung,
 dat_erstellung,
 handling_unit_id_nach,
 handling_unit_guid_nach,
 handling_unit_id_von,
 handling_unit_guid_von,
 bestandsart_id,
 charge_id,
 gefahrstoff_fg,
 aktivitaetsbereich_id,
 art_guid,
 menge_ist_bme,
 menge_ist_ame,
 rollback_fg,
 art_id,
 gp_id,
 queue_id,
 datzeit_bestaetigung,
 dat_bestaetigung,
 lagertyp_id_von,
 artikelsortiment_id,
 lagersortiment_id,
 distanz_reserve_fixplatz,
 distanz_bsf_reserve,
 distanz_hoehe,
 handling_unit_id_nach_fixplatz,
 handling_unit_id_nach_bsf,
 handling_unit_id_nach_hoehe,
 lagertyp_id_nach_distanz,
 lagerplatz_id_nach_distanz,
 lagerplatz_id_nach,
 lagerplatz_id_von,
 selbstabhol_fg,
 lageraufgabe_orig_fg
FROM kfl_production_dbp_msi_data.lageraufgabe_we_2;