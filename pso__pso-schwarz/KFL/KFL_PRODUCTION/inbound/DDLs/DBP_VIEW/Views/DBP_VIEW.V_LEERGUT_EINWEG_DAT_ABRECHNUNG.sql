CREATE OR REPLACE VIEW DBP_VIEW.V_LEERGUT_EINWEG_DAT_ABRECHNUNG (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,leergutautomat_schluessel_id             COMMENT 'ID des Leergutautomaten. Eindeutig im Land'
  ,datzeit_verarbeitung                     COMMENT 'Zeitstempel, wann die Daten bei ESB verarbeitet worden sind. In einigen Fällen werden die Daten eines Automaten an zwei verschiedenen Tagen im System verarbeitet, daher wurde diese Spalte als Primärschlüssel hinzugefügt.'
  ,dat_ruecknahme                           COMMENT 'Tag der Rücknahme (Reportingdatum) ist der Tag, an dem der Kunde die Einwegflaschen im Automaten abgegeben hat.'
  ,einweg_typ_kz                            COMMENT 'Kennzeichen für Eigen-Einwegpfand (E) oder Fremd-Einwegpfand (F). Eigen-Einwegpfand bezieht sich auf Einwegpfandflaschen, die von der von Kaufland stammen.'
  ,leergutautomat_id                        COMMENT 'ID des Leergutautomaten. Eindeutig in der Filiale.'
  ,wup_id                                   COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'
  ,menge_einweg                             COMMENT 'Menge der geschredderten Einwegpfandflaschen.'
  ,dat_tagesabschluss                       COMMENT 'Tag des Tagesabschlusses (Business date).'
)
COMMENT = 'Die Tabelle beinhaltet die Menge der geschredderten EINWEG Pfandflaschen. Sie betrifft nur Leergut Einweg. Daten kommen über ESB. Es werden immer die Daten geliefert, die "gestern" verarbeitet worden sind. Inhalltlich sind das die Daten vom Vor-Vortag.'
 AS 
    SELECT 
        mandant_id,
        leergutautomat_schluessel_id,
        datzeit_verarbeitung,
        dat_ruecknahme,
        einweg_typ_kz,
        leergutautomat_id,
        wup_id,
        nb_id,
        menge_einweg,
        dat_tagesabschluss

FROM DBP_DATA.LEERGUT_EINWEG_DAT_ABRECHNUNG ;