--==============================================================
-- Table: art_umbewertung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_umbewertung_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_UMBEWERTUNG_1 CLUSTER BY (
     MANDANT_ID,
     DAT_UMBEW 
) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   umbew_beleg_id                      NUMBER(18,0)     NOT NULL COMMENT 'Belegnummer der Umbewertung_1 aus SAP UBLNR',
   umbew_beleg_pos_id                  NUMBER(38,0)     NOT NULL COMMENT 'Positionsnummer des Belegs aus uzeil',
   kj                                  NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahr des Belegs aus ubjahr',
   preis_aend_grund_id                 NUMBER(38,0)     NOT NULL COMMENT 'ID des Preisänderungsgrunds, z-Bsp. 12. Aus pv_grund',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig);',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_umbew                           DATE             NOT NULL COMMENT 'Kalenderdatum der Umbewertung_1 im Format JJJJ-MM_1-TT. Aus vpdat',
   vk_brutto_alt                       NUMBER(9,2)      NOT NULL COMMENT 'alter Verkausfspreis VPALT aus USEG',
   menge_umbew                         NUMBER(18,3)     NOT NULL COMMENT 'Bestandsmenge in Basismengeneinheit aus menge: Das Feld wird in SAP nicht mehr fortgeschrieben',
   diff_wert_bestand_brutto            NUMBER(18,2)     NOT NULL COMMENT 'Wert der Umbewertung_1 mit Steuern auf Basis der Bestandmenge aus USEG.VKSAD',
   diff_wert_bestand_netto             NUMBER(18,2)     NOT NULL COMMENT 'Wert der Umbewertung_1 ohne Steuern auf Basis der Bestandmenge aus USEG.VKSADN',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   menge_erf                           NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Erfassungsmengeneinheit zur VK_1-Preisumbewertung aus erfmg',
   menge_bestand_bme                   NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Gesamter bewerteter Bestand aus lbkum',
   wert_bestand_brutto_alt             NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Wert des gesamten bewerteten Bestands zum (Brutto)Verkaufspreis vor der Umbewertung_1 aus vksal_old',
   verk_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsmengeneinheit zu menge_erf. Aus vrkme',
   buchungskreis_id                    NUMBER(38,0)     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt.Aus shkzg',
   art_id_bf                           NUMBER(38,0)     COMMENT 'Artikel_1, auf dem der Bestand geführt wird aus matbf. Referenz zu art_1',
   vk_brutto_neu                       NUMBER(9,2)      NOT NULL DEFAULT 0 COMMENT 'neuer Verkausfspreis vpneu aus USEG',
   wert_bestand_netto_alt              NUMBER(18,2)     NOT NULL DEFAULT 0 COMMENT 'Bestandswert zu netto alt aus vksaln_old',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_UMBEWERTUNG PRIMARY KEY (mandant_id, umbew_beleg_id, umbew_beleg_pos_id, kj) NOT ENFORCED
)  COMMENT = 'WWC - Verkaufspreis-Umbewertungsbelege aus den Tabellen USEG und ZUSEG';

