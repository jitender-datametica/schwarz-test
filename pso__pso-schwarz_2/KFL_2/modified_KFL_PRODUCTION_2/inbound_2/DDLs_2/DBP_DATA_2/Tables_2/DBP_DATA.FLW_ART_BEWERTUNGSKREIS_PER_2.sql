--==============================================================
-- Table: flw_art_bewertungskreis_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_bewertungskreis_per_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_BEWERTUNGSKREIS_PER_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, ab dem der Preis gültig ist',
   bewertungskreis_id                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt  ',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem der Preis gültig ist, bei aktuell gültigen Sätzen ist dies der 31.12.9999',
   preis_steuer_kz                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen Preissteuerung aus vprsv',
   gld                                 NUMBER(29,6)     NOT NULL COMMENT 'Gleitender Durchschnittspreis aus verpr',
   standard_preis                      NUMBER(29,4)     NOT NULL COMMENT 'Standardpreis aus stprs',
   preis_faktor                        INTEGER     NOT NULL COMMENT 'Ganzzahliger Faktor, durch den der Preis geteilt werden muss, um auf den Preis pro Basiseinheit zu kommen aus peinh',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_BEWERTUNGSKREIS_PER PRIMARY KEY (mandant_id, flw_art_id, dat_von, bewertungskreis_id) NOT ENFORCED
)  COMMENT = 'FLW - Diese Tabelle bildet den gleitenden Durchschnittspreis ab. Quelle ist mbew';

