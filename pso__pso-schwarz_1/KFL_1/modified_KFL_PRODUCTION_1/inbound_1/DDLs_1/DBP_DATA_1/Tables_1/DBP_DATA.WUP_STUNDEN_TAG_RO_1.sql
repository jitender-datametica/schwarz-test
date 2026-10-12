--==============================================================
-- Table: WUP_STUNDEN_TAG_RO_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: WUP_STUNDEN_TAG_RO_1
   generated from Powerdesigner on Montag, 22. November 2021 17:43:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_STUNDEN_TAG_RO_1 CLUSTER BY (mandant_id, wup_id)(
   wup_id                              INTEGER          NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER          NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          INTEGER          NOT NULL COMMENT 'Mandant_1 im DWH',
   dat                                 DATE            NOT NULL COMMENT 'Datum',
   stunden_markt                       NUMBER(29,2)     COMMENT 'Nettostunden IST : geleistete Stunden_1 in der Filiale - DE: Aggregation aus PEP - Ausland: Eingabe (Transaction) durch Filiale',
   stunden_sonstige                    NUMBER(29,2)     COMMENT 'Nettostunden IST : zusaetzliche Stunden_1, Umlage Stunden_1 andere Filialen - INT : Eingabe (Transaction) durch Filiale',
   stunden_plan                        NUMBER(29,2)     COMMENT 'Nettostunden Plan : geplante Stunden_1 in der Filiale - INT : Eingabe (Transaction) durch Filiale',
   stunden_co5_sonstige                NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Spalte entfaellt',
   ums_netto_plan                      NUMBER(29,2)    DEFAULT 0.00 NOT NULL COMMENT 'Umsatz netto Plan : Tagesumsatzplanwert von CO (wup_plan_tag_1/vis_tag_umsatz_kunde_wup_1)',
   ums_netto_plan_man                  NUMBER(29,2)    COMMENT 'Umsatz netto Plan HL_1 : dient zur Berechnung der Nettoleistung HL_1  - INT : Eingabe (Transaction) durch Filiale',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' DEFAULT '   ' NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   stunden_sonstige_plan               NUMBER(29,2)     COMMENT 'Nettostunden Plan : geplante Stunden_1 fuer Sondersachverhalte - INT : Eingabe (Transaction) durch Filiale',
   stunden_co1_iks                     NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Nettostunden IST : Korrekturposition z.B. Stundenkorrektur bei Falschpflege durch Markt (IKS) - Excelupload durch CO',
   stunden_co2_ea                      NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Nettostunden IST : Korrekturposition z.B. Entlastung Einarbeitung - Excelupload durch CO',
   stunden_co3_anue                    NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Nettostunden IST : Korrekturposition z.B. Entlastung Preiseinholung - Excelupload durch CO',
   stunden_co4_reinigung               NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Nettostunden IST / Nettostunden Plan : Korrekturposition z.B. Pauschalansatz Reinigung - Excelupload durch CO',
   stunden_versetzung                  NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Nettostunden IST : Stunden_1 fuer untertaegige Versetzungen - INT : Eingabe (Transaction) durch Filiale',
   stunden_plan_pep                    NUMBER(29,2)     DEFAULT 0.00 NOT NULL COMMENT 'Nettostunden Plan : geplante Stunden_1 Filiale - DE : Aggregation aus PEP - Ausland: nicht verfuegbar',
   stunden_plan_meldeschluss_plus1     NUMBER(29,2)     COMMENT 'Nettostunden Plan zum Zeitpunkt des Meldeschluss  (Zahlen muessen zum 18. des Vormonats fuer den kompletten Monat_1 gemeldet sein) - wird im ETL am 18. des Vormonats aus Spalte stunden_plan kopiert',
   ums_netto_plan_man_meldeschluss_plus2 NUMBER(29,2)    COMMENT 'Umsatz netto Plan HL_1 zum Zeitpunkt des Meldeschluss  (Zahlen muessen zum 26. des Vor-Vormonats fuer den kompletten Monat_1 gemeldet sein) - wird im ETL am 26. des Vor-Vormonats aus Spalte ums_netto_plan_man kopiert',
   stunden_co_ist                      NUMBER(29,2)     COMMENT 'Summe der Bereiche aus Excelbeladung - Excelpflege durch Controlling. Externe IST Stunden_1 (z.B. Reinigung durch ext. Firma)',
   stunden_co_plan                     NUMBER(29,2)     COMMENT 'Summe der Bereiche aus Excelbeladung - Excelpflege durch Controlling. Externe PLAN Stunden_1 (z.B. Reinigung durch ext. Firma)',
   stunden_plan_meldeschluss_plus2     NUMBER(29,2)     COMMENT '26. Folge-Folge, wird im ETL am 26. des Vor-Vormonats aus Spalte stunden_plan kopiert',
   ums_netto_plan_man_meldeschluss_plus1 NUMBER(29,2)    COMMENT '18. Folge, wird im ETL am 18. des Vormonats aus Spalte ums_netto_plan_man kopiert',
   stunden_co_plan_plus1               NUMBER(29,2)     COMMENT '18. Folge Monat_1, Wird im ETL am 18. des Vormonats aus Spalte stunden_co_plan kopiert',
   stunden_co_plan_plus2               NUMBER(29,2)     COMMENT '26. Folge-Folge Monatz, Wird im ETL am 18. des Vor-Vormonats aus Spalte stunden_co_plan kopiert.',
   stunden_sonstige_plan_plus1         NUMBER(29,2)     COMMENT '18. Folge Monat_1, Wird im ETL am 18. des Vormonats aus Spalte stunden_sonstige_plan kopiert.',
   stunden_sonstige_plan_plus2         NUMBER(29,2)     COMMENT '26. Folge-Folge Monat_1, Wird im ETL am 26. des Vor-Vormonats aus Spalte stunden_sonstige_plan kopiert.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'VIS - geleistete Stunden_1 pro Tag_1 und Markt fuer Rumaenien. Quellen sind PEP-Daten oder per Transaction Service im DWH erfasste Daten';
