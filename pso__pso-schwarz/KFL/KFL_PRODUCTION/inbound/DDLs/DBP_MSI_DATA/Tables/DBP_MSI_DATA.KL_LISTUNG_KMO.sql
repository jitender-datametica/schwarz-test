--==============================================================
-- Table: kl_listung_kmo
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kl_listung_kmo
   generated from Powerdesigner on Donnerstag, 7. Oktober 2021 17:10:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.kl_listung_kmo  CLUSTER BY (
      mandant_id,
      kjwo_update,
      listung_art
 )(
   kl_listung_kmo_id                   NUMBER(38,0)    NOT NULL DEFAULT 0 COMMENT 'Automatischer generierter Schluessel',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   listung_art                         VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Vorschlagswert bezueglich Listung aus Stored Procedure (z.B. Listung erweitern)',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   sm_id_selected                      NUMBER(38,0)    DEFAULT -1 COMMENT 'Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet',
   ksm_id_selected                     VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Kaufland Sortimentsmodul, das in den KMO Laendern eingefuehrt wurde fuer parallele Listungen zu sm_id.',
   sm_id                               NUMBER(38,0)    DEFAULT -1 COMMENT 'Sortimentsmodul ID. Es gibt 8 Sortimentsstufen. -1: keine Sortimentsstufe zugeordnet',
   ksm_id                              VARCHAR(4)      COLLATE 'en-ci' COMMENT 'Kaufland Sortimentsmodul, das in den KMO Laendern eingefuehrt wurde fuer parallele Listungen zu sm_id.',
   umsatz_hr                           NUMBER(18,4)    NOT NULL COMMENT 'Hochrechnung Umsatz (stored Procedure zur Laufzeit der Ermittlung)',
   absatz_hr                           NUMBER(18,4)    NOT NULL COMMENT 'Hochrechnung Absatz (stored Procedure zur Laufzeit der Ermittlung)',
   rohertrag_hr                        NUMBER(18,4)    NOT NULL COMMENT 'Hochrechnung Rohertrag (stored Procedure zur Laufzeit der Ermittlung)',
   erweiterung_fg                      NUMBER(38,0)    DEFAULT 0 COMMENT 'Flag, wenn Listungserweiterung',
   reduktion_fg                        NUMBER(38,0)    DEFAULT 0 COMMENT 'Flag, wenn Listungsreduktion',
   kjwo_update                         NUMBER(38,0)    DEFAULT 999912 NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   list_kz                             VARCHAR(2)      COLLATE 'en-ci' COMMENT 'Flag, wenn aktuell gelistet',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'EK-SORT -  Sortimentstool - Tabelle fuer KMO fuer Zwischenablage der Hochrechnungsergebnisse KL-Artikel ';