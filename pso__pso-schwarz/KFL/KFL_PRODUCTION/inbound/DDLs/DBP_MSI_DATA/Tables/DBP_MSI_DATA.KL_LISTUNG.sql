--==============================================================
-- Table: kl_listung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kl_listung
   generated from Powerdesigner on Donnerstag, 7. Oktober 2021 16:56:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.kl_listung  CLUSTER BY (
      listung_art,
      kjwo_update,
      art_id
 )(
   kl_listung_id                       NUMBER(38,0)    NOT NULL DEFAULT 0 COMMENT 'Automatischer generierter Schluessel',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   listung_art                         VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Vorschlagswert bezueglich Listung aus Stored Procedure (z.B. Listung erweitern)',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   sm_id_selected                      NUMBER(38,0)    NOT NULL COMMENT 'Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet',
   sm_id                               NUMBER(38,0)    NOT NULL COMMENT 'Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet',
   ost_basis                           VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   ost_gross                           VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   sued_ost                            VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   sued_west                           VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   west                                VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   nord                                VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Listungsinformation abgeleitet aus SAL (Sternchenlogik)',
   umsatz_hr                           NUMBER(18,4)    COMMENT 'Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)',
   absatz_hr                           NUMBER(18,4)    COMMENT 'Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)',
   rohertrag_hr                        NUMBER(18,4)    COMMENT 'Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)',
   kjwo_update                         NUMBER(38,0)    DEFAULT 999912 NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   erweiterung_fg                      NUMBER(38,0)    DEFAULT 0 COMMENT 'Flag, wenn Listungserweiterung',
   reduktion_fg                        NUMBER(38,0)    DEFAULT 0 COMMENT 'Flag, wenn Listungsreduktion',
   list_kz                             VARCHAR(2)      COLLATE 'en-ci' DEFAULT '' COMMENT 'Flag, wenn aktuell gelistet',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'EK-INT -  Sortimentstool - Tabelle fuer Zwischenablage der Hochrechnungsergebnisse KL-Artikel';