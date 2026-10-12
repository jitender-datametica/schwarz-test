--==============================================================
-- Table: avq_werbung_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_werbung_tag_1
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AVQ_WERBUNG_TAG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   dat_aktion_von                      DATE             NOT NULL COMMENT 'Werbung/Aktion_1 gültig ab',
   dat_aktion_bis                      DATE             NOT NULL COMMENT 'Werbung/Aktion_1 gültig bis',
   tag_index                           INTEGER     NOT NULL COMMENT 'Index, der den wievielten Tag_1 der Aktion_1 anzeigt. Gegebenenfalls negativ für WE(Wareneingang) vor Aktion.',
   dat                                 DATE             COMMENT 'Einzelner Kalendertag des Gültigkeitszeitraums der Werbung/Aktion.',
   menge_bestand                       NUMBER(29,3)     COMMENT 'Bestand in Basis-ME',
   menge_abverkauf                     NUMBER(29,3)     COMMENT 'Abverkaufsmenge  in Basis-ME am betreffenden Datum der Werbung',
   menge_abverkauf_af                  NUMBER(29,3)     COMMENT 'Abverkauf Aktionsfrei (AF) in Basis-ME',
   menge_abverkauf_sa                  NUMBER(29,3)     COMMENT 'Abverkauf Sonderaktion (SA) in Basis-ME',
   menge_we                            NUMBER(29,3)     COMMENT 'Menge Wareneingang in Basis-ME',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   betrag_umsatz_netto                 NUMBER(29,3)     COMMENT 'Umsatz Netto',
   exc209_fg                           INTEGER     COMMENT 'Flag gibt an, ob ein Nullbestand gemäß der Exception 209 in F&R vorliegt. Exception 209 bedeutet einen Nullbestand. Quelle im DWH: dbp_data.ausnahme_1, aus SAP F&R.',
   nullbestand_fg                      NUMBER(29,3)     COMMENT 'Flag gibt an, ob ein Nullbestand für den Artikel_1 am Lagerort ausgewiesen wird. Quelle: SAP Retail (Tabelle MARD_1).',
   exc214_fg                           INTEGER     COMMENT 'Flag gibt an, ob ein Minusbestand gemäß der Exception 214 in F&R vorliegt. Exception 214 bedeutet Minusbestand. Quelle im DWH: dbp_data.ausnahme_1, aus SAP F&R.',
   minusbestand_fg                     NUMBER(29,3)     COMMENT 'Flag gibt an, ob ein Minusbestand für den Artikel_1 am Lagerort ausgewiesen wird. Quelle: SAP Retail (Tabelle MARD_1).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AVQ_WERBUNG_TAG PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis, tag_index) NOT ENFORCED
)  COMMENT = 'AVQ(Abverkaufsquote) Kennzahlen aus Tages Ebene - Zusatzebene, enthält einen Datensatz pro Tag_1 der Aktion_1 (Datum+Index) sowie Datensätze für WE vor Aktion_1 (negativer Index)';
