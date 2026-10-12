--==============================================================
-- Table: tms_rechnung_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_rechnung_det_1
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_RECHNUNG_DET_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_rech_beleg_id                   INTEGER     NOT NULL COMMENT 'ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr',
   tms_rech_beleg_pos_id               VARCHAR(8)       NOT NULL COMMENT 'Rechnungspositionsnummer. Aus plrpos.beleg_posnr',
   tms_rech_pos_lfd_nr                 INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_rechnung_det_1 im Quellsystem. Aus plrpos.rpos_id',
   dat_tms_rech_beleg                  DATE             NOT NULL COMMENT 'Belegdatum',
   preis_einzel                        NUMBER(29,3)     COMMENT 'Preis pro Einheit (Ansatz)',
   betrag_vor_rabattabzug              NUMBER(29,3)     COMMENT 'Rechungsbetrag vor Rabattabzug',
   betrag_netto                        NUMBER(29,3)     COMMENT 'Nettoendbetrag der Belegposition',
   mwst                                NUMBER(29,2)      COMMENT 'MwSt-Satz',
   tms_konto_id                        INTEGER     COMMENT 'Konto_1 ID, entspricht der Kostenart_1 (Basispreis, Zuschlag Kühlung,…)',
   bewertungseinheit_cd                VARCHAR(20)      COMMENT 'Bewertungseinheit (nicht SAP-Mengeneinheiten, z. B. auch L-St. für Ladestellen möglich)',
   tms_rech_org_pos_id                 INTEGER     COMMENT 'Organisatorische Positionsnummer',
   tms_rech_pos_txt                    VARCHAR(300)     COMMENT 'Rechnungspositionstext',
   tms_rech_pos_leist_typ_cd           VARCHAR(8)       COMMENT 'Leistungsart',
   tms_rech_pos_leist_typ_bez          VARCHAR(30)      COMMENT 'Bezeichnung zur Leistungsart',
   menge_effektiv                      NUMBER(29,3)     COMMENT 'Effektive Menge',
   menge_frachtpflichtig               NUMBER(29,3)     COMMENT 'Frachtpflichtige Menge',
   tms_tour_id                         INTEGER     COMMENT 'Tournummer',
   dat_tour                            DATE             COMMENT 'Tourdatum',
   bewertungseinheit_id                INTEGER     COMMENT 'Eine_1 abstrakte ID, um alles zusammenzufassen, was bewertet wird (entspricht i.d.R. einer Tour_1, ist aber nicht die Tournummer). Einheit bezieht sich hier auf die Einheit, die bewertet wird, z. B. eine_1 Tour_1 (evtl. kann Wanko auch mehrere Touren zusammenfassen - de facto ist es aber eine_1 1:1-Beziehung).',
   reklamation_fg                      INTEGER     COMMENT 'Kennzeichen: Reklamation',
   bearbeitet_fg                       INTEGER     COMMENT 'Kennzeichen: Wurde Bearbeitet',
   reklamation_txt                     VARCHAR(300)     COMMENT 'Text zur Reklamation',
   tms_rech_pos_referenz_lfd_nr        INTEGER     COMMENT 'Laufende Nummer der ursprünglichen Rechnungsposition, auf die sich diese (meistens als Reklamation oder Ablehnung einer Reklamation erfasste) Position bezieht. Bezieht sich immer auf eine_1 Position innerhalb derselben Rechnung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_RECHNUNG_DET PRIMARY KEY (mandant_id, tms_rech_beleg_id, system_id, tms_rech_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die detaillierte Informationen zu einzelnen Rechnungspositionen, einschließlich TMS-Tourbezeichnung, Menge, Preis und Mehrwertsteuersatz. Aus der Quelle plrpos (WANKO)';
