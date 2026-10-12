--==============================================================
-- Table: ts_autodispo_dif_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_autodispo_dif_2
   generated from Powerdesigner on Freitag, 30. April 2021 16:01:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ts_autodispo_dif_2 (
   mandant_id_kunde                    INTEGER    NOT NULL COMMENT 'Mandant_2 Markt',
   wup_id_kunde                        INTEGER    NOT NULL COMMENT 'Markt',
   nb_id_kunde                         INTEGER    NOT NULL COMMENT 'Nebenbetrieb Markt',
   mandant_id_vz                       INTEGER    NOT NULL COMMENT 'Mandant_2 VZ',
   wup_id_vz                           INTEGER    NOT NULL COMMENT 'Verteilzentrum',
   nb_id_vz                            INTEGER    NOT NULL COMMENT 'Nebenbetrieb VZ',
   frische_manager_id                  INTEGER    NOT NULL COMMENT 'Leiter Frische',
   art_id                              INTEGER    NOT NULL COMMENT 'Artikel_2  - Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   vs_id                               INTEGER    NOT NULL COMMENT 'Region_2  - ID der Vertriebsschiene. Vertriebs-Sicht auf die wup_2 Objekte',
   vkl_id                              INTEGER    NOT NULL COMMENT 'Verkaufsleiter',
   wg_id                               INTEGER    NOT NULL COMMENT 'ID der Warengruppe',
   art_gruppe_id                       VARCHAR(5)      DEFAULT '-1   ' NOT NULL COMMENT 'Artikelgruppe  - ID der Artikel_2-Gruppierung (System generiert im DWH)',
   dat_von                             DATE            NOT NULL COMMENT 'Gueltig Von  :  Datum im Format JJJJ-MM_2-TT',
   dat_bis                             DATE            NOT NULL COMMENT 'Gueltig Bis   :  Datum im Format JJJJ-MM_2-TT',
   sa_af_fg                            INTEGER    NOT NULL COMMENT 'SA oder AF (Sonderaktion oder Aktionsfrei) SA/AF steuerung -> SA, AF oder beides',
   dif_funktion_id                     VARCHAR(1)      NOT NULL COMMENT 'DIF Funktion (I/U/D)',
   dif_typ_id                          INTEGER    NOT NULL COMMENT 'DIF Typ (Mult., Add., Abs.)',
   menge_einh_id                       VARCHAR(3)      NOT NULL COMMENT 'Mengeneinheit',
   dif_status_id                       INTEGER    NOT NULL COMMENT 'DIF Status_2 ',
   dif_wert                            NUMBER(29,3)    NOT NULL COMMENT 'DIF Wert',
   dif_kommentar                       VARCHAR(100)    COMMENT 'DIF Kommentar',
   dif_timestamp TIMESTAMP_NTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
   art_cluster_id                      INTEGER    DEFAULT -1 NOT NULL COMMENT 'Artikelcluster ID',
   wup_cluster_id                      INTEGER    DEFAULT -1 NOT NULL COMMENT 'Marktcluster ID',
   werbegruppe_fleisch                 VARCHAR(10)     DEFAULT '-1' NOT NULL COMMENT 'Werbegruppe Fleisch',
   dateiname                           VARCHAR(255)    DEFAULT ' ' COMMENT 'Dateiname (bei Sharepoint-Upload)',
   dat_upload                          DATE            COMMENT 'Datum (bei Sharepoint-Upload)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Transaction Service Table for Autodispo Report';