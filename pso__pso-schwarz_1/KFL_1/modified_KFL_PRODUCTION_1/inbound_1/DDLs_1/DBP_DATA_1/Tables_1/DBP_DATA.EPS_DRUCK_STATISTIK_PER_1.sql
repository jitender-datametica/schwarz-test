--==============================================================
-- Table: eps_druck_statistik_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_druck_statistik_per_1
   generated from Powerdesigner on Freitag, 17. März 2023 11:13:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EPS_DRUCK_STATISTIK_PER_1 (
   eps_druck_statistik_id              INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Druckauftrags in der Druck-Statistik',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kl_art_id                           INTEGER     COMMENT '7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer',
   druck_anlass_id                     VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Anlass des Drucks; (z.B. PE (Preiserhöhung).',
   datzeit_anforderung                 TIMESTAMP_NTZ(9) COMMENT 'Zeitpunkt zu dem der Printjob gedruckt werden soll',
   datzeit_druck                       TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel, wann das Ettikett gerduckt wurde',
   containertyp_id                     INTEGER     COMMENT 'ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)',
   layout_groesse_id                   INTEGER     COMMENT 'ID der Layoutgröße; (z.B. 1 = Mini, 9 = A4, …)',
   papierart_id                        INTEGER     COMMENT 'ID der Papierart; (z.B. 3 = weiss A4, 200 = neon-orange A4, …)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EPS_DRUCK_STATISTIK_PER PRIMARY KEY (eps_druck_statistik_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Druckstatistik aus EPS (printstatitics)';