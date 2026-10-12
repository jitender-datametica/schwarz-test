--==============================================================
-- Table: umlagerung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: umlagerung_2
   generated from Powerdesigner on Freitag, 19. Januar 2024 15:29:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.umlagerung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wa_lagerbew_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Materialbelegnummer des Warenausgangs in der abgebenden Filiale, Hochzählende Nummer pro Land_2 und Jahr.'),
wa_lagerbew_beleg_kj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kalenderjahr des Belegs im Warenausgang der abgebenden Filiale.'),
wa_wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Warenumschlagsplatz der abgebenden Filiale.'),
wa_nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.'),
dat_buchung_wa DATE NOT NULL
OPTIONS(description='Datum der Verarbeitung der Umlagerung_2 bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen,'),
we_lagerbew_beleg_id BIGNUMERIC(38,0)
OPTIONS(description='Materialbelegnummer im Wareneingang der empfangenden Filiale, Hochzählende Nummer pro Land_2 und Jahr.'),
we_lagerbew_beleg_kj BIGNUMERIC(38,0)
OPTIONS(description='Kalenderjahr des Belegs im Wareneingang der abgebenden Filiale.'),
we_wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Warenumschlagsplatz der empfangenden Filiale.'),
we_nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP.'),
dat_buchung_we DATE
OPTIONS(description='Datum der Verarbeitung der Umlagerung_2 bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
umlagerung_status_kz STRING(1) NOT NULL
OPTIONS(description='Kennzeichen für den Status_2 der Umlagerung_2: W = Wareneingang gebucht, S = Storniert, O = Offen.'),
anz_beleg_pos BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl der Buchungspositionen im Materialbeleg.'),
vk_netto BIGNUMERIC(38,4) NOT NULL OPTIONS(description='Verkaufswert der Positionen der Umlagerung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wa_lagerbew_beleg_id, wa_lagerbew_beleg_kj) NOT ENFORCED
)
OPTIONS(description='Tabelle beinhaltet Informationen zu Umlagerungen. Eine_2 Umlagerung_2 ist der Transport von Artikeln zwischen zwei Filialen.');