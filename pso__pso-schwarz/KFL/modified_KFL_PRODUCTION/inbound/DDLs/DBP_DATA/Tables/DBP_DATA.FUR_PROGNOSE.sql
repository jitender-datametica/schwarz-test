--==============================================================
-- Table: fur_prognose
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_prognose
   generated from Powerdesigner on Freitag, 11. April 2025 15:42:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FUR_PROGNOSE CLUSTER BY (
     MANDANT_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer',
   nb_id                               INTEGER     NOT NULL COMMENT ' Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'DWH-Artikelnummer',
   dat                                 DATE             NOT NULL COMMENT 'Prognosedatumim Format JJJJ-MM-TT',
   menge_prognose                      NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean ',
   menge_prognose_bef                  NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect',
   menge_prognose_max                  NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max',
   listung_id                          INTEGER     NOT NULL COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Denormalisiert - aus art_wup_zu_per angereichert',
   kdis                                INTEGER     NOT NULL COMMENT 'kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel ist über den normalen Weg bestellbar, 1: der Artikel wird  zugeteilt',
   dispomerkmal                        VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Dispomerkmal. Denormalisiert aus der Tabelle art_wup_status_per. Referenz zur Lookuptabelle l_dispomerkmal',
   progn_groesser_fg                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
   menge_af_groesser_fg                INTEGER     NOT NULL DEFAULT 0 COMMENT 'menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
   menge_prognose_aktion               NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Prognostizierte Aktionsmenge. Wird vorläufig nur gefüllt sein für Backshop-Artikel (WG 291), wenn sie in Aktion sind. Aus der Quellspalte fc_act',
   prognose_horizont                   INTEGER     NOT NULL DEFAULT 0 COMMENT 'Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von ZFRE_DWH_FCST.menge_01 bis menge_35 waren gefüllt)',
   menge_ofc                           NUMBER(29,3)     COMMENT 'Menge OF',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FUR_PROGNOSE PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat) NOT ENFORCED
)  COMMENT = 'AIS - Hier werden die prognostizierten Abverkaufsmengen aus SAP F&R für 35 Tage im Voraus und mehrere Jahre historisch gespeichert';
