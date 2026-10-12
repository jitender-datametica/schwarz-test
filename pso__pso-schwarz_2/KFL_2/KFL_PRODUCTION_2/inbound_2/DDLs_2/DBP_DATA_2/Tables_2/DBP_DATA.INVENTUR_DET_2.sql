--==============================================================
-- Table: inventur_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_det_2
   generated from Powerdesigner on Mittwoch, 7. September 2022 15:15:33
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_DET_2 CLUSTER BY (MANDANT_ID)(
   inv_beleg_id                        NUMBER(18,0)    NOT NULL COMMENT 'ID des Inventurbelegs aus iblnr',
   gj                                  NUMBER(38,0)    NOT NULL COMMENT 'Geschaeftsjahr, Format JJJJ',
   inv_beleg_pos_id                    NUMBER(38,0)    NOT NULL COMMENT 'Position des Inventurbelegs aus zeili',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   dat_letzt_zaehl                     DATE            NOT NULL COMMENT 'Datum der letzten Zaehlung aus zldat',
   lagerort_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Schluessel fuer die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort',
   dat_buch                            DATE            NOT NULL COMMENT 'Buchungsdatum im Beleg aus budat',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   lagerbew_beleg_id                   NUMBER(18,0)    COMMENT 'Das Feld enthaelt die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.',
   lagerbew_beleg_pos_id               NUMBER(38,0)    COMMENT 'Das Feld enthaelt die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile ',
   kj                                  NUMBER(38,0)    COMMENT 'Dieses Attribut enthaelt das entsprechende Kalenderjahr und wird benoetgit um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren.aus mjahr ',
   erfsngs_menge_einh_id               VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Erfassungsmengeneinheit der Inventur_2 aus der Spalte erfme. Referenz zur Tabelle l_einh_2',
   menge_erf                           NUMBER(18,3)    DEFAULT 0 NOT NULL COMMENT 'Menge in Erfassungsmengeneinheit aus erfmg',
   menge_buch                          NUMBER(18,3)    DEFAULT 0 NOT NULL COMMENT 'Buchmenge zur Zaehlung aus buchm',
   menge_zaehl                         NUMBER(18,3)    DEFAULT 0 NOT NULL COMMENT 'Zaehlmenge in Basismengeneinheit aus menge',
   wert_diff_inv                       NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Differenzbetrag in Hauswaehrung aus dmbtr',
   wert_vk_brutto                      NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Wert zu Verkaufspreisen brutto aus vkwrt',
   wert_vk_extern                      NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'extern eingegebener Verkaufswert in Hauswaehrung aus exvkw',
   wert_vk_netto                       NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Wert zu Verkaufspreisen netto aus vkwra',
   vk_inventur_diff_brutto             NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Verkaufswert Inventurdifferenz brutto bei Zaehlerfassung aus vkmzl',
   vk_inventur_diff_netto              NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Verkaufswert Inventurdifferenz netto bei Zaehlerfassung aus vknzl',
   wert_zaehl                          NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Wert der Inventurzaehlung (netto) zum Zeitpunkt der Inventurerfassung aus wrtzl',
   wert_menge_buch                     NUMBER(18,4)    DEFAULT 0 NOT NULL COMMENT 'Wert der Buchmenge (netto) zum Zeitpunkt der Zaehlerfassung',
   nullzaehl_fg                        NUMBER(38,0)    NOT NULL COMMENT 'Nullzaehlung Flag. Wenn = 1, ist die gezaehlte Menge = 0. Aus xnull',
   beleg_erfasser_id                   VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'ID des Beleg-Erfassers. Kann Batch-Usernamen oder FB enthalten. Aus Datenschutzgruenden darf in den Bewegungsdaten nur der Fachbereich des Erfassers abgebildet werden.Wird aus dem Quellfeld usnaz erzeugt',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_DET PRIMARY KEY (inv_beleg_id, gj, inv_beleg_pos_id, mandant_id) NOT ENFORCED
)  COMMENT = 'WWC - Positionsdaten des Inventurbelegs aus der SAP Tabelle iseg';
