--==============================================================
-- Table: in_best_belegfluss
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_best_belegfluss
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_BEST_BELEGFLUSS (
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs aus ebeln',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
   folge_beleg_id                      INTEGER     NOT NULL COMMENT 'Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann 
            Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr',
   kj                                  INTEGER     NOT NULL COMMENT 'Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr',
   folge_beleg_pos_id                  INTEGER     NOT NULL COMMENT 'Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei',
   kontierung_pos_id                   INTEGER     NOT NULL,
   vorgart_best_entw_id                VARCHAR(1)       NOT NULL COLLATE 'en-ci',
   dat_buch                            DATE             COMMENT 'Buchungsdatum des Beleges aus budat',
   betrag_wrbtr                        NUMBER(29,4)     COMMENT 'Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten',
   best_entw_typ_id                    VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Kennzeichen über die Art des Folgebeleges: 
            E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein, Q = Rechnung',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg',
   wrg_id_beleg                        VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_BEST_BELEGFLUSS PRIMARY KEY (best_beleg_id, mandant_id, best_beleg_pos_id, folge_beleg_id, kj, folge_beleg_pos_id, kontierung_pos_id, vorgart_best_entw_id) NOT ENFORCED
)  COMMENT = 'BIS - In dieser Tabelle ist die Historie zu dem Bestellbeleg aus der SAP Industrie Quelle EKBE hinterlegt. ';
