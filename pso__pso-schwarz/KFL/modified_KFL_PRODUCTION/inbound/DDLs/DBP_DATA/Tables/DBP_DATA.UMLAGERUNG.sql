--==============================================================
-- Table: umlagerung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: umlagerung
   generated from Powerdesigner on Freitag, 19. Januar 2024 15:29:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.UMLAGERUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wa_lagerbew_beleg_id                INTEGER     NOT NULL COMMENT 'Materialbelegnummer des Warenausgangs in der abgebenden Filiale, Hochzählende Nummer pro Land und Jahr.',
   wa_lagerbew_beleg_kj                INTEGER     NOT NULL COMMENT 'Kalenderjahr des Belegs im Warenausgang der abgebenden Filiale.',
   wa_wup_id                           INTEGER     NOT NULL COMMENT 'ID des Warenumschlagsplatz der abgebenden Filiale.',
   wa_nb_id                            INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.',
   dat_buchung_wa                      DATE             NOT NULL COMMENT 'Datum der Verarbeitung der Umlagerung bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen,',
   we_lagerbew_beleg_id                INTEGER     COMMENT 'Materialbelegnummer im Wareneingang der empfangenden Filiale, Hochzählende Nummer pro Land und Jahr.',
   we_lagerbew_beleg_kj                INTEGER     COMMENT 'Kalenderjahr des Belegs im Wareneingang der abgebenden Filiale.',
   we_wup_id                           INTEGER     NOT NULL COMMENT 'ID des Warenumschlagsplatz der empfangenden Filiale.',
   we_nb_id                            INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP.',
   dat_buchung_we                      DATE             COMMENT 'Datum der Verarbeitung der Umlagerung bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   umlagerung_status_kz                VARCHAR(1)       NOT NULL COMMENT 'Kennzeichen für den Status der Umlagerung: W = Wareneingang gebucht, S = Storniert, O = Offen.',
   anz_beleg_pos                       INTEGER     NOT NULL COMMENT 'Anzahl der Buchungspositionen im Materialbeleg.',
   vk_netto                            NUMBER(29,4)     NOT NULL COMMENT 'Verkaufswert der Positionen der Umlagerung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_UMLAGERUNG PRIMARY KEY (mandant_id, wa_lagerbew_beleg_id, wa_lagerbew_beleg_kj) NOT ENFORCED
)  COMMENT = 'Tabelle beinhaltet Informationen zu Umlagerungen. Eine Umlagerung ist der Transport von Artikeln zwischen zwei Filialen.';
