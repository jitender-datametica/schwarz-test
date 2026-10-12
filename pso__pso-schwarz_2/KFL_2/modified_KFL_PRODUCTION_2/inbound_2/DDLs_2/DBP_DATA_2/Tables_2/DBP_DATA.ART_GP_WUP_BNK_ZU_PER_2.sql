--==============================================================
-- Table: art_gp_wup_bnk_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_wup_bnk_zu_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GP_WUP_BNK_ZU_PER_2 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   dat_von                             DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn des Datensatzes.',
   nb_id                               INTEGER     COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_bis                             DATE             COMMENT 'Gueltigkeitsende des Datensatzes.',
   cycle_id                            INTEGER,
   betrag_auslandsfracht               NUMBER(29,4)      COMMENT 'Wert der Auslandsfracht.',
   betrag_auslandsfracht2              NUMBER(29,4)      COMMENT 'Wert der Auslandsfracht 2.',
   betrag_zoll                         NUMBER(29,4)      COMMENT 'Wert des Zolls.',
   betrag_antidump                     NUMBER(29,4)      COMMENT 'Wert/Betrag fuer Anti Dumping.',
   betrag_inlandsfracht                NUMBER(29,4)      COMMENT 'Wert der Inlandsfracht.',
   betrag_gem_rueckn                   NUMBER(29,4)      COMMENT 'Wert/Betragfuer das gemeinsame Ruecknahmesystem.',
   betrag_duales_system                NUMBER(29,4)      COMMENT 'Wert/Betrag fuer das duale System Deutschland.',
   betrag_gema                         NUMBER(29,4)      COMMENT 'Wert/Betrag fuer die GEMA Gebuehr.',
   betrag_verbrauchsst                 NUMBER(29,4)      COMMENT 'Wert der Verbruachssteuer.',
   betrag_verpackung                   NUMBER(29,4)      COMMENT 'Wert/Betrag fuer die Verpackung.',
   betrag_prov                         NUMBER(29,4)      COMMENT 'Wert/Betrag der Provision.',
   betrag_hk_prov                      NUMBER(29,4)      COMMENT 'Wert/Betrag der Hong Kong Provision.',
   betrag_agentur_prov                 NUMBER(29,4)      COMMENT 'Wert/Betrag der Agentur Provision.',
   betrag_mto                          NUMBER(29,4)      COMMENT 'Wert der MTO (Markant Trading Organiszation) Konditionen.',
   betrag_pruefkosten                  NUMBER(29,4)      COMMENT 'Wert der Pruefungskosten.',
   betrag_eu_regelung                  NUMBER(29,4)      COMMENT 'Wert/Betrag der EU Regelung.',
   betrag_sonst_kosten                 NUMBER(29,4)      COMMENT 'Wert/Betrag der sonstigen Kosten.',
   kond_einh_id                        VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Konditionseinheit (Waehrung oder Prozentsatz).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GP_WUP_BNK_ZU_PER PRIMARY KEY (system_id, mandant_id, art_id, gp_id, einkaufsorganisation_id, wup_id, dat_von) NOT ENFORCED
)  COMMENT = 'RPW - Diese Tabelle enthaelt zeitabhaengig die statistisch geplanten Bezugsnebenkosten pro Artikel_2, Lieferant und WUP. Quelle fuer diese Information ist die SAP Tabelle ZBNK.';

