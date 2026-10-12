--==============================================================
-- Table: flw_datenpool
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_datenpool
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_DATENPOOL CLUSTER BY (DAT_LIEF) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   verteilprozess_id                   INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Satzes aus dist_pr_data_id',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   datenpool_satzart_id                VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Wertevorrat: PN = Plannummer, DP = Disponentprognose, FP = Filialeprognose auf Zeitpunkt, AM = Produktionsauftrag (MyMeat), KA = Kommissionieraufträge, KP = Kommissionierpositionen, LI = Lieferpositionen aus zdps_satzart ',
   dat_produktion                      DATE             NOT NULL COMMENT 'Produktionsdatum aus zdps_prod_date',
   objekt_id                           INTEGER     COMMENT 'enthält zum Beispiel die Beleg Id vbeln. Quelle ist object_number',
   werk_id                             INTEGER     COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_lief                            DATE             NOT NULL COMMENT 'Lieferdatum aus lieferdatum',
   dat_mat_bereitstllg                 DATE             NOT NULL COMMENT 'Datum der Materialbereitstellung aus mbdat',
   zeit_mat_bereitstllg                INTEGER     NOT NULL COMMENT 'Zeitpunkt der Materialbereitstellung aus mbuhr',
   flw_tourart_id                      VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Tourart, z.Bsp. PRG aus zdps_tour',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   verk_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsmengeneinheit, z.Bsp. E1 aus vrkme',
   anz_kolli_produzier                 NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Anzahl produzierte Kolli aus zdps_bestmg_produziert',
   komm_auftrag_status_id              VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kommissionier-Auftrags-Status aus zdps_kauf_status.',
   handling_unit_id_ext                VARCHAR(20)      COLLATE 'en-ci' COMMENT 'externe Handing Unit ID aus exidv. Compress',
   lagernummer_id                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer aus lgnum',
   lief_beleg_id                       INTEGER     NOT NULL COMMENT 'Nummer, die die Lieferung eindeutig identifiziert. Quelle vbeln',
   flw_art_id_verpackung               INTEGER     NOT NULL COMMENT 'Artikel ID des Ladungsträgers = Verpackungsmaterial aus zdps_verp_matnr',
   verp_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Internationalen Maßeinheit aus msehi',
   menge_produziert                    NUMBER(29,3)     NOT NULL COMMENT 'Produzierte Menge aus menge_produziert',
   menge_prognose                      NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Prognosemenge aus bestmg_fil',
   kolli_vol                           INTEGER     NOT NULL COMMENT 'Volumen des Kollis aus zdps_kolli_volum',
   kolli_vol_einh_id                   VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der alternativen Mengeneinheit aus meinh',
   menge_absolut                       NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Absolute Menge aus zdps_am_absolut',
   menge_bestand                       NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Bestandsmenge aus atp_quantity_d',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_DATENPOOL PRIMARY KEY (verteilprozess_id) NOT ENFORCED
)  COMMENT = 'FLW - Datenpool aus spdps_idp222010';

