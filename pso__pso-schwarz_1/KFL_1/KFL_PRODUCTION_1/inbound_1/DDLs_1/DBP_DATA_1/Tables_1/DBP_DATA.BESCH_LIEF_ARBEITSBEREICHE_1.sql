--==============================================================
-- Table: besch_lief_arbeitsbereiche_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_arbeitsbereiche_1
   generated from Powerdesigner on Montag, 19. September 2022 08:27:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_LIEF_ARBEITSBEREICHE_1 CLUSTER BY (
     MANDANT_ID,
     DAT_LIEF_SOLL 
)(
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   lagerort_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kunde_id                            NUMBER(38,0)    NOT NULL COMMENT 'Als Format wurde bewusst Integer gewählt - ist kein Versehen',
   wtag_id                             NUMBER(38,0)    NOT NULL COMMENT 'Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag',
   dat_lief_soll                       DATE            NOT NULL COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen.',
   wg_id                               NUMBER(38,0)    NOT NULL COMMENT 'ID der Warengruppe',
   arthiertyp_id                       NUMBER(38,0)    NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   disponent_id                        VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Disponent ID',
   wg_verkett_id                       NUMBER(38,0)    NOT NULL COMMENT 'Die Warengruppenverkettung ist artikelbezogen. Wird in SAP auf die Kopftabelle hochgezogen, die erste Position als Quelle. Stimmt also bei Mischpaletten nicht für alle Positionen. Referenziert auf die Tabelle l_wg_verkettung. Das SAP-Feld ist zzlwgrv',
   disposition_rhythmus_ltf_id         VARCHAR(3)      COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'ID für den Dispositionsrhythmus (wie oft, an welchen Wochentagen)',
   terminierungsgruppe_1_id            VARCHAR(3)      COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'LTF: Terminierungsgruppe 1',
   terminierungsgruppe_2_id            VARCHAR(2)      COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'LTF: Terminierungsgruppe 2',
   terminierungsgruppe_3_id            VARCHAR(2)      COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'LTF: Terminierungsgruppe 3',
   auslieferungsgruppe_id              VARCHAR(4)      COLLATE 'en-ci' DEFAULT '-1' NOT NULL COMMENT 'ID der Auslieferungsgruppe',
   kunde_bez                           VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Compress',
   disposition_rhythmus_id             VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender',
   disponent_name                      VARCHAR(30)     COLLATE 'en-ci' NOT NULL COMMENT 'Name des Disponenten',
   wup_standort                        VARCHAR(40)     COLLATE 'en-ci' COMMENT 'Ortsbezeichnung',
   bestellart_id                       VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'ID der Bestellart (bsart)',
   lief_pal_typ_id                     VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_1 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.',
   diff_id                             VARCHAR(1)      COLLATE 'en-ci' NOT NULL COMMENT 'Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.',
   menge_lief_ist_kolli                NUMBER(18,3)    NOT NULL COMMENT 'Anzahl der Kollis der Lieferposition. Ermittlung bei der Kommisionierung',
   menge_lief_soll_kolli               NUMBER(18,3)    NOT NULL COMMENT 'Die Soll-Liefermenge dient dazu, die ursprüngliche Liefermenge einer Aus- oder Anlieferung festzuhalten. Sie bezieht sich auf die Mengeneinheit der Liefermenge (LFIMG). Es handelt sich hier um Kolli!  ',
   betrag_lief_ist                     NUMBER(18,2)    COMMENT 'redundantes Feld, um den join zur art_gp_wup_zu_per_1 zu sparen, berechnet anzahl_kolli*ek_netto_bnk*komponentenmenge. Format decimal(18,4)',
   betrag_lief_soll                    NUMBER(18,2)    COMMENT 'redundantes Feld, um den join zur art_gp_wup_zu_per_1 zu sparen, berechnet menge_lief_soll*ek_netto_bnk*komponentenmenge. Format decimal(18,4)',
   menge_lief_palette                  NUMBER(18,3)    NOT NULL COMMENT 'Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_1 und art_umrechnung_faktor_per_1 ermittelt.',
   mandant_id_kunde                    NUMBER(38,0)    DEFAULT 1 NOT NULL COMMENT 'Der Kunde kann zu einem anderen Mandanten als der WUP_1 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_LIEF_ARBEITSBEREICHE PRIMARY KEY (mandant_id, lagerort_id, wup_id, nb_id, kunde_id, wtag_id, dat_lief_soll, wg_id, arthiertyp_id, disponent_id, wg_verkett_id, disposition_rhythmus_ltf_id, terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id, auslieferungsgruppe_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Aggregat für den Bericht Arbeitsbereiche';
