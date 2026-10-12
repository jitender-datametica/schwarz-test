--==============================================================
-- Table: aktion_werbemengen_einholung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_werbemengen_einholung
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_WERBEMENGEN_EINHOLUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr',
   wg_id                               INTEGER     NOT NULL COMMENT 'Warengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   schlagwort                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Schlagwörter. Z.B. AME alle Häuser 2017',
   dat_von                             DATE             COMMENT 'Abverkauf an Endverbraucher ab',
   dat_bis                             DATE             COMMENT 'Abverkauf an Endverbraucher bis',
   status_einholung_id                 INTEGER     COMMENT 'Status der Einholung',
   status_einholung_markt_kz           VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Status der Einholung im Markt',
   dat_rueckmeldung                    DATE             COMMENT 'Rückmeldedatum Betrieb',
   dat_bis_rueckmeldung                DATE             COMMENT 'letzter Rückmeldetermin für die Aktionsbekanntmachung',
   dat_aktionsbekanntmachung           DATE             COMMENT 'Datum der Aktionsbekanntmachung',
   anzahl_artikel_offen                INTEGER     COMMENT 'Anzahl Artikel offen - Status 2',
   anzahl_artikel_gesamt               INTEGER     COMMENT 'Anzahl Artikel gesamt - auf WGR Ebene',
   aktion_typ_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Aktionstyp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_WERBEMENGEN_EINHOLUNG PRIMARY KEY (mandant_id, wup_id, nb_id, aktion_id, wg_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Artikel/Aktionen auf WGR-level für Filiale - SAP RET - ZEK_WGR_MARKT';

