--==============================================================
-- Table: art_vw_listung_von
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_listung_von
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_VW_LISTUNG_VON (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   vw_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebsweges',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   dat_von                             DATE             NOT NULL COMMENT 'Datum der letzten Listungsänderung. Pro Schlüssel ist nur das letzte Datum gespeichert',
   sm_id                               NUMBER(38,0)     NOT NULL DEFAULT -9 COMMENT 'Hier: groesste sm_id mit einer durchgaengigen Listung',
   ksm_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' DEFAULT '-9' COMMENT 'Kaufland Sortimentsmodul, das in den KMO Ländern eingeführt wurde für parallele Listungen zu sm_id.',
   dat_erst_listung                    DATE             NOT NULL COMMENT 'Datum der ersten Listung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_VW_LISTUNG_VON PRIMARY KEY (mandant_id, vw_id, art_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Pro Artikel und Vertriebsweg wird die Durchgängigkeit der Listung angezeigt';

