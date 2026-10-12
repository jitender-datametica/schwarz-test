--==============================================================
-- Table: wbs_aktion_art_wup_menge_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_aktion_art_wup_menge_2
   generated from Powerdesigner on Dienstag, 23. April 2024 10:38:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_AKTION_ART_WUP_MENGE_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   wup_id_vz                           NUMBER(38,0)     NOT NULL COMMENT 'Verteilzentrum.',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   nb_id_vz                            NUMBER(38,0)     NOT NULL COMMENT 'Nebenbetrieb (VZ).',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   dat_ab                              DATE             NOT NULL COMMENT 'Aktion_2 gueltig von.',
   dat_bis                             DATE             NOT NULL COMMENT 'Aktion_2 gueltig bis.',
   bonuskauf_promotionstyp             VARCHAR(4)       COMMENT 'Promotion Type (Field AKART in PMR) , expected entries e.g. 0001, 0005, ZAI, ZBBR.',
   dat_lief_split                      DATE             COMMENT 'Lieferdatum Split-Logik. Aus Tabelle wbs_art_wup_aktion_initial.',
   bestellmenge_final_ame              NUMBER(18,3)     COMMENT 'Finale Bestellmenge in AME. Order amount which was initially calculated for the promotion. Saves certain values from table wbs_werbeaenderungen_2 in case/before it gets overwritten..',
   menge_initial_ame                   NUMBER(9,3)      COMMENT 'Initialmenge in AME. Delivery amount which was calculated for the initial delivery. It is a part of the full calculated promotional quantity. Saves certain values from table wbs_art_wup_aktion_initial_2 in case/before it gets overwritten.',
   menge_wbs                           NUMBER(18,3)     COMMENT 'Delivery amount which was sent out after the adjustment calculation by WBS. Can be less than the remaining amount of the product (the calculated total promotional quantity minus the initial delivery). Saves certain values from table best_vorschlag_wbs_2 in case/before it gets overwritten.',
   init_lief_modus_kz                  VARCHAR(100)     COMMENT 'Beschreibt den Modus, in welchem die Initiale Belieferung berechnet wird (O = Order, S = Simulation, N = None)
            - N: wenn noch keine initiale Belieferung errechnet wurd  (vor wbs_phase_id = 8)
            - S: berechnen die Erstlieferung 40 Tage vor der Promotion - es werden keine wirklichen Bestellungen in den Geschäften erzeugt sondern die Spalte ermöglicht  DC Dispo, den ersten Liefersplit schon sehr früh zu sehen und die Mengen beim Lieferanten entsprechend zu bestellen, wbs_phase_id 7 bis 3
            - O: der ursprüngliche initiale Lieferlauf findet  9 Tage vor der Promotion  statt, und der Berechnungslauf wird als "O" (Order Creation) gekennzeichnet,  ab wbs_phase_id 2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_AKTION_ART_WUP_MENGE PRIMARY KEY (mandant_id, wup_id, wup_id_vz, nb_id, nb_id_vz, art_id, dat_ab, dat_bis) NOT ENFORCED
)  COMMENT = 'Table stores promotion amounts for recalculation to reduce overstock. Original Tables overwrite the values every day so this table is needed to keep the relevant values.
             To reduce the exceptions of overstock (Überdeckung) in DC Dispo Interface a new process of transferring the promotion amounts is implemented.
             The aim is to provide information from the replenishment core (about promotion amount, initial delivery, adjustment amount and especially the rest amount projection) to simulate, that the whole blocked amount is distributed to the stores. This should reduce the exceptions of overstock.';
