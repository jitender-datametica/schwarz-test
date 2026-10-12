CREATE OR REPLACE VIEW kfl_production_dbp_view.v_umlagerung_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
wa_lagerbew_beleg_id
OPTIONS(description='Materialbelegnummer des Warenausgangs in der abgebenden Filiale, Hochzählende Nummer pro Land_2 und Jahr.'),
wa_lagerbew_beleg_kj OPTIONS(description='Kalenderjahr des Belegs im Warenausgang der abgebenden Filiale.'), wa_wup_id
OPTIONS(description='ID des Warenumschlagsplatz der abgebenden Filiale.'), wa_nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.'),
dat_buchung_wa
OPTIONS(description='Datum der Verarbeitung der Umlagerung_2 bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen,'),
we_lagerbew_beleg_id
OPTIONS(description='Materialbelegnummer im Wareneingang der empfangenden Filiale, Hochzählende Nummer pro Land_2 und Jahr.'),
we_lagerbew_beleg_kj OPTIONS(description='Kalenderjahr des Belegs im Wareneingang der abgebenden Filiale.'), we_wup_id
OPTIONS(description='ID des Warenumschlagsplatz der empfangenden Filiale.'), we_nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP.'),
dat_buchung_we
OPTIONS(description='Datum der Verarbeitung der Umlagerung_2 bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), umlagerung_status_kz
OPTIONS(description='Kennzeichen für den Status_2 der Umlagerung_2: W = Wareneingang gebucht, S = Storniert, O = Offen.'),
anz_beleg_pos OPTIONS(description='Anzahl der Buchungspositionen im Materialbeleg.'), vk_brutto
OPTIONS(description='Brutto Verkaufswert der Positionen der Umlagerung.')) AS SELECT mandant_id,
 wa_lagerbew_beleg_id,
 wa_lagerbew_beleg_kj,
 wa_wup_id,
 wa_nb_id,
 dat_buchung_wa,
 we_lagerbew_beleg_id,
 we_lagerbew_beleg_kj,
 we_wup_id,
 we_nb_id,
 dat_buchung_we,
 wrg_id,
 umlagerung_status_kz,
 anz_beleg_pos,
 vk_brutto
FROM kfl_production_dbp_data.umlagerung_2;