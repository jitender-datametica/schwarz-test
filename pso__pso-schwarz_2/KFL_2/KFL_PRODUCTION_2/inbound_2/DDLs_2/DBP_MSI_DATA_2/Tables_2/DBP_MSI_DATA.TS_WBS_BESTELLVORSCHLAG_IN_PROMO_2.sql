--==============================================================
-- Table: ts_wbs_bestellvorschlag_in_promo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_bestellvorschlag_in_promo_2
   generated from Powerdesigner on Dienstag, 28. Juli 2026 09:23:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_BESTELLVORSCHLAG_IN_PROMO_2 (
   mandant_id                          NUMBER(18,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   art_id                              NUMBER(18,0)     NOT NULL COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   wup_id                              NUMBER(18,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               NUMBER(18,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   dat_aktion_von                      DATE             NOT NULL COMMENT 'Aktion_2 gültig von.',
   dat_aktion_bis                      DATE             NOT NULL COMMENT 'Aktion_2 gültig bis.',
   menge_bestellvorschlag_in_promo_ame NUMBER(18,3)     COMMENT 'Bestellvorschlag aus dem Promo Dossier (<> 7 Tage Aktionsdauer oder Ultrafrische), der anhand der Bestandsreichweite berechnet werden kann und/oder manuell eingetragen werden kann. Mengeneinheit AME.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_BESTELLVORSCHLAG_IN_PROMO PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_aktion_von, dat_aktion_bis) NOT ENFORCED
)  COMMENT = 'Writeback-Tabelle für Bestellvorschläge aus dem WBS Promo-Dossier. Speichert systemisch berechnete sowie manuell angepasste Bestellmengen für Aktionsartikel außerhalb des TP1-Standardprozesses (Aktionsdauer <> 7 Tage oder Ultrafrische) auf Markt-Artikel_2-Aktionszeitraum-Ebene.';
