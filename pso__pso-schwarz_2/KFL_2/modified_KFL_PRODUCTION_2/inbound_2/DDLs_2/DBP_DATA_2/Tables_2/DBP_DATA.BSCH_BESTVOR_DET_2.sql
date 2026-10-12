--==============================================================
-- Table: bsch_bestvor_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bsch_bestvor_det_2
   generated from Powerdesigner on Donnerstag, 25. Januar 2024 08:04:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BSCH_BESTVOR_DET_2 CLUSTER BY (
     MANDANT_ID,
     DAT_PLAN 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   best_vor_nr                         INTEGER     NOT NULL COMMENT 'Bestellvorschlagsnummer, bei Bestellungen ohne Vorschlag die Bestellnummer aus der Tabelle besch_best_2',
   best_vor_pos                        INTEGER     NOT NULL COMMENT 'Bestellvorschlagsposition',
   dat_plan                            DATE             NOT NULL COMMENT 'Planungsdatum',
   art_id                              INTEGER     NOT NULL COMMENT 'Eindeutige Artikelnummer',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   menge_best_vor                      NUMBER(29,4)     NOT NULL COMMENT 'Vorgeschlagene Menge',
   menge_best                          NUMBER(29,4)     NOT NULL COMMENT 'Bestellte Menge',
   status_2                              VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Status_2 der Position: 
            "VB"  unveränderte Übernahme Vorschlag in Bestellung
            "V0"  Vorschlag ohne Bestellung
            "0B" Bestellung ohne Vorschlag
            "V+" Bestellvorschlag erhöht
            "V-" Bestellvorschlag reduziert
            ',
   best_vor_einh                       INTEGER     NOT NULL COMMENT 'Faktor zur vorgeschlagenen Menge, umgerechnet über art_umrechnung_fakor_per',
   best_einh                           INTEGER     NOT NULL COMMENT 'Faktor zur bestellten Menge, umgerechnet über art_umrechnung_fakor_per',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' DEFAULT '    ' COMMENT 'Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.',
   dat_lief_soll                       DATE             COMMENT 'Soll-Lieferdatum aus ZFRE_BV (fur_best_vor_2)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BSCH_BESTVOR_DET PRIMARY KEY (best_vor_nr, best_vor_pos, mandant_id) NOT ENFORCED
)  COMMENT = 'AIS -  F&R - Aggregat der Bestellvorschläge - MULTISET  ab KW 19/12 entfällt die bisherige SST - wird jetzt aus der Tabelle fur_best_vor_2 befüllt';
