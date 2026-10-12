CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_LAGERAUFGABE_WE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,lagernummer_id                           COMMENT 'Lagernummer/Lagerkomplex'
  ,lageraufgabe_id                          COMMENT 'Lageraufgabe_1'
  ,lageraufgabe_pos_id                      COMMENT 'Lageraufgabenposition'
  ,best_beleg_id                            COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.'
  ,lief_beleg_id                            COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation des Lieferscheinlbelegs. '
  ,transportation_unit_id                   COMMENT 'Transporteinheit '
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,transportation_unit_sr_act_id            COMMENT 'Transporteinheit  transportation_unit_sr_act_id '
  ,transportation_unit_id_ext               COMMENT 'Transporteinheit (extern)'
  ,lagerprozessart_id                       COMMENT 'Lagerprozessart'
  ,status_id                                COMMENT 'Lageraufgabenstatus'
  ,lagerprozess_id                          COMMENT 'Lagerungsprozess'
  ,zz_colli_qty                             COMMENT 'Kollimenge (zz_colli_qty)'
  ,menge_kolli                              COMMENT 'Kollimenge (berechnet)'
  ,menge_pal                                COMMENT 'Palettenmenge'
  ,lagerbereich_id_nach                     COMMENT 'Nachlagerbereich'
  ,lagertyp_id_nach                         COMMENT 'Nach-Lagertyp'
  ,le_typ_id                                COMMENT 'Handling-Unit_1-Typ'
  ,gewicht_netto                            COMMENT 'Ladungs- / Nettogewicht'
  ,gewicht_brutto                           COMMENT 'Bruttogewicht der jeweiligen Wareneingangs-Position. Es beinhaltet das Gewicht der Ladung.'
  ,gew_einh_id                              COMMENT 'Gewichtseinheit'
  ,volumen                                  COMMENT 'Ladungs- oder Nettovolumen'
  ,vol_einh_id                              COMMENT 'Volumeneinheit'
  ,dat_mhd                                  COMMENT 'Best-Before Date / Shelf Life Expiration Date'
  ,datzeit_we                               COMMENT 'Datum und Uhrzeit des Wareneingangs'
  ,dat_we                                   COMMENT 'Datum und Uhrzeit des Wareneingangs'
  ,datzeit_erstellung                       COMMENT 'Erstellungszeitpunkt'
  ,dat_erstellung                           COMMENT 'Erstellungszeitpunkt'
  ,handling_unit_id_nach                    COMMENT 'Nach-Handling-Unit_1'
  ,handling_unit_guid_nach                  COMMENT 'eindeutige interne Identifikation einer Handling Unit_1'
  ,handling_unit_id_von                     COMMENT 'Von-Handling-Unit_1'
  ,handling_unit_guid_von                   COMMENT 'eindeutige interne Identifikation einer Handling Unit_1'
  ,bestandsart_id                           COMMENT 'Bestandsart'
  ,charge_id                                COMMENT 'Charge'
  ,gefahrstoff_fg                           COMMENT 'Gefahrstoff'
  ,aktivitaetsbereich_id                    COMMENT 'Aktivitätsbereich'
  ,art_guid                                 COMMENT 'Product'
  ,menge_ist_bme                            COMMENT 'Istmenge in Basismengeneinheit'
  ,menge_ist_ame                            COMMENT 'Istmenge in alternativer Mengeneinheit'
  ,rollback_fg                              COMMENT 'Lageraufgabe_1'
  ,art_id                                   COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'
  ,gp_id                                    COMMENT 'Geschäftspartner - ID (Lieferanten - ID)'
  ,queue_id                                 COMMENT 'Queue'
  ,datzeit_bestaetigung                     COMMENT 'Bestätigungszeit in Lagerzeitzone'
  ,dat_bestaetigung                         COMMENT 'Erstelldatum der Bestätigung'
  ,lagertyp_id_von                          COMMENT 'Von-Lagertyp'
  ,artikelsortiment_id                      COMMENT 'Kauflandspezifische Info Sortiments ID'
  ,lagersortiment_id                        COMMENT 'Lagersortiment ID.'
  ,distanz_reserve_fixplatz                 COMMENT 'TDC Reserve zu Fixplatz'
  ,distanz_bsf_reserve                      COMMENT 'TDC BSF zu Reserve'
  ,distanz_hoehe                            COMMENT 'TDC Höhenaufschlag'
  ,handling_unit_id_nach_fixplatz           COMMENT 'ID der Handling Unit_1 (z. B. Palette) auf die sich die Distanz zum Fixplatz bezieht'
  ,handling_unit_id_nach_bsf                COMMENT 'ID der Handling Unit_1 (z. B. Palette) auf die sich die Distanz zur BSF bezieht'
  ,handling_unit_id_nach_hoehe              COMMENT 'ID der Handling Unit_1 (z. B. Palette) auf die sich der Höhenaufschlag bezieht'
  ,lagertyp_id_nach_distanz                 COMMENT 'Nach-Lagertyp abhängig vom Prozess'
  ,lagerplatz_id_nach_distanz               COMMENT 'Nach-Lagerplatz abhängig vom Prozess'
  ,lagerplatz_id_nach                       COMMENT 'Nachlagerplatz'
  ,lagerplatz_id_von                        COMMENT 'Vonlagerplatz'
  ,selbstabhol_fg                           COMMENT 'Das Flag kennzeichnet die Selbstaholung dieser Position, Wert 1 entspricht selbstabgeholt.Aus klvs_kzselbstabh'
  ,lageraufgabe_orig_fg                     COMMENT 'Markiert den jew. ersten Datensatz pro Lageraufgabe_1, sodass bei > 1 Zeile Kennzahlen nicht verdoppelt werden (Multiplikation Kennzahl*Flag in Frontend-MV).'
)
COMMENT = 'Wareneingangs-Positionen (Zusammenführung Lieferung+Bestellung+Handling Unit_1)'
 AS 
    SELECT 
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

FROM DBP_MSI_DATA.LAGERAUFGABE_WE_1 ;