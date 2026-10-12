--==============================================================
-- Table: in_besch_best_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_besch_best_det
   generated from Powerdesigner on Montag, 22. August 2022 09:49:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_BESCH_BEST_DET (
   best_beleg_id                       NUMBER(18,0)    NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs aus ebeln',
   best_beleg_pos_id                   NUMBER(38,0)    NOT NULL COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   in_art_id                           NUMBER(38,0)    NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   menge_best_bme                      NUMBER(18,3)    NOT NULL COMMENT 'bestellte Menge des Artikel dieser Position in Bestellmengeneinheit aus menge',
   best_menge_einh_id                  VARCHAR(3)      NOT NULL COMMENT 'Einheit der Bestellmenge aus meins. Entspricht nicht meins aus der Tabelle mara!',
   best_preis_menge_einh_id            VARCHAR(3)      COMMENT 'ID der alternativen Mengeneinheit aus meinh',
   loesch_id                           VARCHAR(1)      NOT NULL COMMENT 'die loesch_id enthält das Löschkennzeichen für diese Position aus loekz',
   werk_id                             NUMBER(38,0)    NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   retourenpos_fg                      NUMBER(38,0)    NOT NULL COMMENT 'Das Flag gibt an ob die Position eine Retourenposition ist aus retpo',
   dupli_fg                            NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Bestimmte Positionen werden im SAP dupliziert und manipuliert und im Feld ekpo.txz01 mit (+) gekennzeichnet. Solche Positionen erhalten im DWH eine 1',
   besch_pos_typ_id                    VARCHAR(1)      NOT NULL COMMENT 'Positionstyp im Einkaufsbeleg aus pstyp. Wichtig für FLW ist die Ausprägung 0 = Normal, evtl. noch 5= Strecke',
   system_id                           NUMBER(38,0)    NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   nettopreis                          NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Gibt den Nettopreis pro Preiseinheit an. Aus netpr',
   betrag_pos_netto_best_wrg           NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Nettobestellwert in Bestellwährung aus netwr',
   endrech_fg                          NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Endrechnungs Flag aus erekz',
   rech_plan_id                        NUMBER(18,0)    COMMENT 'Rechnungsplannummer aus fplnr. Hat eine Referenz zur SAP Tabelle FPLA',
   bsak_dat_buch                       DATE            COMMENT 'Buchungsdatum der Rechnung.Wird aus der Tabelle bsak zu Performancezwecken angereichert',
   menge_bme                           NUMBER(18,3)    DEFAULT 0 NOT NULL COMMENT 'Bestellmenge in Basismengeneinheit (Einheit in in_art vorhanden), kann von marm abweichen, aus ekpo.umrez/ekpo.umren errechnet, für BIS benötigt',
   unterposition_typ_id                VARCHAR(1)      DEFAULT ' ' NOT NULL COMMENT 'Auftrags- oder Unterpositionstyp aus uptyp',
   in_wg_id                            VARCHAR(10)     DEFAULT '          ' NOT NULL COMMENT 'Warengruppe aus dem Industriesystem. Quelle ist matkl',
   k_shop_fg                           NUMBER(38,0)    COMMENT 'Kennzeichen, ob der Artikel zum Zeitpunkt der Bestellung (bsak_dat_buch) im K-Shop gelistet ist',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_BESCH_BEST_DET PRIMARY KEY (best_beleg_id, best_beleg_pos_id, mandant_id) NOT ENFORCED
)  COMMENT = 'BIS - Bestellungen  - Detaildaten aus SAP EKPO - MULTISET';
