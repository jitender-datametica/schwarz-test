--==============================================================
-- Table: leergut_einweg_dat_abrechnung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: leergut_einweg_dat_abrechnung_1
   generated from Powerdesigner on Donnerstag, 5. Juni 2025 07:41:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LEERGUT_EINWEG_DAT_ABRECHNUNG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   leergutautomat_schluessel_id        VARCHAR(30)      NOT NULL COMMENT 'ID des Leergutautomaten. Eindeutig im Land_1',
   datzeit_verarbeitung                TIMESTAMP_NTZ(0) NOT NULL COMMENT 'Zeitstempel, wann die Daten bei ESB verarbeitet worden sind. In einigen Fällen werden die Daten eines Automaten an zwei verschiedenen Tagen im System verarbeitet, daher wurde diese Spalte als Primärschlüssel hinzugefügt.',
   dat_ruecknahme                      DATE             NOT NULL COMMENT 'Tag_1 der Rücknahme (Reportingdatum) ist der Tag_1, an dem der Kunde die Einwegflaschen im Automaten abgegeben hat.',
   einweg_typ_kz                       VARCHAR(1)       NOT NULL COMMENT 'Kennzeichen für Eigen-Einwegpfand (E) oder Fremd-Einwegpfand (F). Eigen-Einwegpfand bezieht sich auf Einwegpfandflaschen, die von der von Kaufland stammen.',
   leergutautomat_id                   VARCHAR(30)      NOT NULL COMMENT 'ID des Leergutautomaten. Eindeutig in der Filiale.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   menge_einweg                        INTEGER     NOT NULL COMMENT 'Menge der geschredderten Einwegpfandflaschen.',
   dat_tagesabschluss                  DATE             NOT NULL COMMENT 'Tag_1 des Tagesabschlusses (Business date).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LEERGUT_EINWEG_DAT_ABRECHNUNG PRIMARY KEY (mandant_id, leergutautomat_schluessel_id, dat_ruecknahme, einweg_typ_kz, datzeit_verarbeitung) NOT ENFORCED
)  COMMENT = 'Die Tabelle beinhaltet die Menge der geschredderten EINWEG Pfandflaschen. Sie betrifft nur Leergut Einweg. Daten kommen über ESB. Es werden immer die Daten geliefert, die "gestern" verarbeitet worden sind. Inhalltlich sind das die Daten vom Vor-Vortag.';
