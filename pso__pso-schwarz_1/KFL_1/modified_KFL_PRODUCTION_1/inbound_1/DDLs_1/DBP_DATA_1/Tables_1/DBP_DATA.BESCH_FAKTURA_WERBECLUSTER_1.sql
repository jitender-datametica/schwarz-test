--==============================================================
-- Table: besch_faktura_werbecluster_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_werbecluster_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA_WERBECLUSTER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche, Format JJJJWW',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   art_id                              INTEGER     NOT NULL COMMENT '"Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);
            
            Output: 7stellige L&S-ID + Counter = 9stellige ArtikelID. WWNNNNPCC (Warengruppe, Nummer, Prüfziffer, Counter)
            
            Regel: Neuer Artikel_1 -> Counter +1"
            ',
   faktura_menge_af_1fw                NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge BME AF der ersten Folgewerbewoche',
   faktura_menge_af_2fw                NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge BME AF der zweiten Folgewerbewoche',
   faktura_menge_af_3fw                NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge BME AF der dritten Folgewerbewoche',
   faktura_menge_af_6vw                NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge BME AF der sechsten Vorwerbewoche',
   faktura_menge_sa_1vw                NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge BME SA der ersten Vorwerbewoche',
   faktura_menge_sa_ww                 NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge BME SA der aktuellen Werbewoche',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_FAKTURA_WERBECLUSTER PRIMARY KEY (mandant_id, wup_id, nb_id, kjwo, wg_id, art_id) NOT ENFORCED
)  COMMENT = 'AIS - Aggregat für Fakturmengen auf Wochenebene - MULTISET';

