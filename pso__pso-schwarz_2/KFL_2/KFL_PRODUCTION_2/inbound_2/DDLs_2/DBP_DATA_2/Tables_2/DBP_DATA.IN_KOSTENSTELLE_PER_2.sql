--==============================================================
-- Table: in_kostenstelle_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_kostenstelle_per_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_KOSTENSTELLE_PER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl',
   krk_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
   dat_von                             DATE             NOT NULL COMMENT 'Beginn des Gültigkeitszeitraums aus datab',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende des Gültigkeitszeitraums aus datbi, bei offenen Datensätzen ist dies 31.12.9999',
   pc_id                               VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die Profitcenter',
   buchungskreis_id                    NUMBER(38,0)     COMMENT 'Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   geschaeftsbereich_id                VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber',
   kostenstellenart_id                 VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Kostenstellenart aus kosar, z.Bsp A=Zentr. International, B=Zentr. National, F=Fleischwerk, I=Immo,V=Vertrieb',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_KOSTENSTELLE_PER PRIMARY KEY (mandant_id, kostenstelle_id, krk_id, dat_von) NOT ENFORCED
)  COMMENT = 'IMS - Kostenstellentabelle aus Industrie aus csks';
