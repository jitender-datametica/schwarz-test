--==============================================================
-- Table: besch_lief_fehlmengen_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_fehlmengen_1
   generated from Powerdesigner on Freitag, 28. März 2025 10:36:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_LIEF_FEHLMENGEN_1 CLUSTER BY (
     MANDANT_ID,
     DAT_LIEF_SOLL 
) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1 aus BESCH_LIEF_DET_1 oder angereichert aus BESCH_BEST_DET_1(EKKO_1)',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Verteilzentrum aus BESCH_LIEF_1 bzw. BESCH_BEST_1',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   empfaenger_wup_id                   NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Empfangende Filiale aus BESCH_LIEF_1 bzw. BESCH_BEST_1',
   empfaenger_nb_id                    NUMBER(38,0)     NOT NULL COMMENT 'Nebenbetriebs-ID des empfangenden Marktes. In der Tabelle nur deswegen enthalten, weil FrontEnd ein bestehendes Attribut aus mandant_1, wup_1, nb_1 verwendet',
   mandant_id_empfaenger               NUMBER(38,0)     NOT NULL COMMENT 'Der Empfaenger kann zu einem anderen Mandanten als der liefernde WUP_1 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Lagerort_id',
   dat_lief_soll                       DATE             NOT NULL COMMENT 'Soll Lieferdatum',
   bestellart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Angereichert aus BESCH_BEST_1(EKKO_1)',
   diff_id                             VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Wenn Eintrag in BESCH_LIEF_DET_1 vorhanden dann diff_id aus BESCH_LIEF_DET_1 ansonsten leer',
   kuerzung_fg                         NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Wenn entsprechenden Eintrag in besch_lief_kuerzung_1 vorhanden dann 1 ansonsten 0',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   menge_lief_soll_kolli               NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'bestellte Menge in Kolli umgerechnet',
   menge_lief_ist_kolli                NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'tatsächlich gelieferte Menge in Kolli',
   ek_netto_bnk_soll                   NUMBER(18,4)     COMMENT 'Einkaufspreis netto_bnk bezogen auf die bestellte Menge.',
   ek_netto_bnk_ist                    NUMBER(18,4)     COMMENT 'Einkaufspreis netto_bnk bezogen auf die gelieferte Menge.',
   vk_netto_ist                        NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto  bezogen auf die gelieferte Menge',
   vk_netto_soll                       NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto  bezogen auf die bestellte Menge',
   umrechnungskurs                     NUMBER(38,5)     NOT NULL COMMENT 'Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_1 angereichert',
   umrechnungskurs_hist                NUMBER(38,5)     NOT NULL DEFAULT 0 COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_1 ',
   kuerz_menge_lief_soll_kolli         NUMBER(18,3)     NOT NULL COMMENT 'Gekürzte Soll-Liefermenge in Kolli',
   kuerz_menge_lief_ist_kolli          NUMBER(18,3)     NOT NULL COMMENT 'Gekürzte Ist-Liefermenge in Kolli',
   kuerz_ek_netto_bnk_soll             NUMBER(18,4)     NOT NULL COMMENT 'Einkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge',
   kuerz_ek_netto_bnk_ist              NUMBER(18,4)     NOT NULL COMMENT 'Einkaufspreis netto_bnk bezogen auf die gekürzte Ist-Menge',
   kuerz_vk_netto_soll                 NUMBER(18,4)     NOT NULL COMMENT 'Verkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge',
   kuerz_vk_netto_ist                  NUMBER(18,4)     NOT NULL COMMENT 'Verkaufspreis  bezogen auf die gekürzte Ist-Menge',
   best_beleg_id                       NUMBER(18,0)     COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln',
   best_beleg_pos_id                   NUMBER(38,0)     COMMENT 'Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_LIEF_FEHLMENGEN PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, empfaenger_wup_id, empfaenger_nb_id, mandant_id_empfaenger, lagerort_id, dat_lief_soll, bestellart_id, diff_id, kuerzung_fg, wrg_id) NOT ENFORCED
)  COMMENT = 'AIS KMO - Aggregat für nicht gelieferte Ware in KMO. Wird aus besch_lief_det_1 und besch_lief_kuerzung_1 versorgt und mit Preisen angereichert ';
