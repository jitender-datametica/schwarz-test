--==============================================================
-- Table: protokoll_aenderung_bsf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: protokoll_aenderung_bsf_1
   generated from Powerdesigner on Dienstag, 28. September 2021 15:00:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PROTOKOLL_AENDERUNG_BSF_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   dat_aenderung                       DATE            NOT NULL COMMENT 'Dieses Datum stellt das Übernahmedatum bei einem neuen Beleg bzw. das Updatedatum bei einer neuen Version eines Datensatzes dar.',
   datzeit_aenderung_utc               TIMESTAMP_LTZ   NOT NULL COMMENT 'Änderungszeit in Lagerzeitzone',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   bereitstellungsflaeche              VARCHAR(4)      NOT NULL COMMENT 'Bereitstellungsfläche',
   doppelbelegung_kz                   VARCHAR(1)      NOT NULL COMMENT 'Kennzeichen Doppelbelegung',
   index_nano                          NUMBER(38,0)    NOT NULL COMMENT 'Nanosekunden für Index',
   nb_id                               NUMBER(38,0)    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   transaktion_code                    VARCHAR(20)     COMMENT 'Transaktionscode aus tcode',
   vorgangstyp_id                      VARCHAR(1)      COMMENT 'Vorgangstyp bei Aktualisierung Bereitstellflächen',
   abbruchbedingung                    VARCHAR(40)     COMMENT 'Abbruchbedingung bei Verarbeitung in Fu-bausteinen',
   kunde_id                            VARCHAR(10)     COMMENT 'Warenempfänger',
   wgvgrp_id                           NUMBER(38,0)    COMMENT 'Warengruppenverkettungsgruppe - wird benutzt, um die verschiedenen Gebäude an einem VZ zu identifizieren.',
   zlv_bsf_status                      VARCHAR(1)      COMMENT 'Systemstatus einer Bereitstellfläche',
   referenznummer                      VARCHAR(10)     COMMENT 'Referenznummer',
   bestandart_id                       VARCHAR(1)      COMMENT 'Bestandart (Werbung oder Normalware)',
   status_verplant_fg                  NUMBER(38,0)    COMMENT 'Status_1 ''verplant''',
   fixe_einplanung_fg                  NUMBER(38,0)    COMMENT 'Status_1 ''fixe Einplanung''',
   status_verplan_ign_fg               NUMBER(38,0)    COMMENT 'Status_1 ''verplant'' bei Kapazitätsprüfung ignorieren',
   max_kap_bsf                         NUMBER(10,2)    COMMENT 'Maximale eingeplante Kapazität der BSF mit gleicher Referenz',
   anz_pal_bsf                         NUMBER(10,2)    COMMENT 'Anzahl Paletten pro Bereitstellungsfläche',
   verplante_kap                       NUMBER(10,2)    COMMENT 'verplante Kapazität (Summe verpl. Stellplatz)',
   bestand_bsf                         NUMBER(38,0)    COMMENT 'aktueller Bestand Bereitstellungsfläche',
   zlv_stp_ist                         NUMBER(10,2)    COMMENT 'Ist-Stellplatz BSF (belegte Stellplätze)',
   fixe_einplanung_markt_fg            NUMBER(38,0)    COMMENT 'Status_1 ''fixe Einplanung''',
   lag_aktionssort                     VARCHAR(1)      COMMENT 'Lager mit Aktionssortiment',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);
