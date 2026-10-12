--==============================================================
-- Table: flw_art_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   flw_art_nr                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Artikelnummer aus SAP. Quelle ist mara.matnr',
   artikelart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Ordnet das Material einer Gruppe_2 zu. Z.Bsp. HAWA, ZERL. Quelle ist mara.mtart. Lookup-Tabelle ist in FLW im Gegensatz zu IND nicht vorhanden',
   art_id                              INTEGER     COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   basismenge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Einheit der Basismenge, z.Bsp. kg aus mara.meins',
   bedarfsplan_id                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Quelle: spmeat_pbdnr. Enthält char-Angaben wie z.Bsp. hawa, schwein, rind,.... Findet sich auch in der Tabelle art_werk_prognose',
   best_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Einheit der Bestellmenge aus bstme',
   gew_einh_id                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Gewichtseinheit aus gewei',
   nettogew                            NUMBER(29,3)     NOT NULL COMMENT 'Nettogewicht aus ntgew',
   produktgruppe_id                    VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Produktguppe Id aus prodgr. Referenz zur Tabelle flw_produktgruppe_2',
   vol                                 NUMBER(29,3)     NOT NULL COMMENT 'Volumen aus vol',
   vol_einh_id                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Volumeneinheit aus voleh',
   loesch_id                           VARCHAR(2)       COLLATE 'en-ci' COMMENT 'MSTAE - ID des Loeschkennzeichens, z.Bsp. L fuer logisch geloeschte Artikel_2',
   dat_von_loesch_id                   DATE             COMMENT 'MSTDE - Datum, ab dem der betriebsübergreifende ArtStatus (DWH: loesch_id) gültig ist',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART PRIMARY KEY (mandant_id, flw_art_id) NOT ENFORCED
)  COMMENT = 'FLW - Artikelstammdaten aus der Quelle MARA_2';

