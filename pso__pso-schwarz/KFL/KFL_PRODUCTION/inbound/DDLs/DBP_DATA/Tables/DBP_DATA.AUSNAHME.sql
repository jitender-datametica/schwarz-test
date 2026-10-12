--==============================================================
-- Table: ausnahme
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausnahme
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AUSNAHME CLUSTER BY (
     MANDANT_ID,
     DAT_PLAN 
) (
   ausnahme_id                         VARCHAR(32)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Ausnahme aus msghdl',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig);
            Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter)
            Regel: Neuer Artikel -> Counter +1',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Warenumschlagsplatz - Hier die Ziel-Lokation der Ausnahme',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_plan                            DATE             NOT NULL COMMENT 'Planungsdatum',
   pruef_id                            NUMBER(38,0)     NOT NULL COMMENT 'Prüfungsgrund ID',
   z_arbeitsgebiet_id                  NUMBER(38,0)     NOT NULL COMMENT 'In FuR gibt es die Arbeitsgebeite FRE_EMON für Märkte und Z_FRE für VZs. Wird im DWH in 1 und 0 umgesetzt. Offen für weitere Arbeitsgebiete',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID) - Hier die Quell-Lokation Lager oder Lieferant',
   ausnahme_mutter_id                  VARCHAR(32)      COLLATE 'en-ci' COMMENT 'Hier ist bei zusammengehörigen Ausnahmen die übergeordnete ausnahme_id gespeichert, aus high_level_ref',
   ausnahme_menge_bme                  NUMBER(9,3)      COMMENT 'Menge in Basismengeneinheiten. Nur gefüllt bei Prüfgrund 210 und Arbeitsgebiet ZFRE',
   ausnahme_menge_kolli                NUMBER(9,3)      COMMENT 'Menge in Kolli. Nur gefüllt bei Prüfgrund 210 und Arbeitsgebiet ZFRE',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AUSNAHME PRIMARY KEY (ausnahme_id, mandant_id) NOT ENFORCED
)  COMMENT = 'AIS - Die Ausnahmen von den Bestellvorschlaegen F&R ';

