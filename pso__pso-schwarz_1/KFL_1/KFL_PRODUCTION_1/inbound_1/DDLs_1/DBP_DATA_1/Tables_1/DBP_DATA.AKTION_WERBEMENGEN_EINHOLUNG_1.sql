--==============================================================
-- Table: aktion_werbemengen_einholung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_werbemengen_einholung_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_WERBEMENGEN_EINHOLUNG_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   aktion_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr',
   wg_id                               NUMBER(38,0)     NOT NULL COMMENT 'Warengruppe',
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   schlagwort                          VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Schlagwörter. Z.B. AME alle Häuser 2017',
   dat_von                             DATE             COMMENT 'Abverkauf an Endverbraucher ab',
   dat_bis                             DATE             COMMENT 'Abverkauf an Endverbraucher bis',
   status_einholung_id                 NUMBER(38,0)     COMMENT 'Status_1 der Einholung',
   status_einholung_markt_kz           VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Status_1 der Einholung im Markt',
   dat_rueckmeldung                    DATE             COMMENT 'Rückmeldedatum Betrieb',
   dat_bis_rueckmeldung                DATE             COMMENT 'letzter Rückmeldetermin für die Aktionsbekanntmachung',
   dat_aktionsbekanntmachung           DATE             COMMENT 'Datum der Aktionsbekanntmachung',
   anzahl_artikel_offen                NUMBER(38,0)     COMMENT 'Anzahl Artikel_1 offen - Status_1 2',
   anzahl_artikel_gesamt               NUMBER(38,0)     COMMENT 'Anzahl Artikel_1 gesamt - auf WGR Ebene',
   aktion_typ_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Aktionstyp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_WERBEMENGEN_EINHOLUNG PRIMARY KEY (mandant_id, wup_id, nb_id, aktion_id, wg_id, arthiertyp_id) NOT ENFORCED
)  COMMENT = 'VIS - Artikel_1/Aktionen auf WGR-level für Filiale - SAP RET - ZEK_WGR_MARKT';

