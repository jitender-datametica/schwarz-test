--==============================================================
-- Table: in_auftrag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:06:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_AUFTRAG_2 (
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   auftragsart_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Auftragsart aus auart',
   geschaeftsbereich_id                VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber',
   in_budget_typ_id                    VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Eindeutige ID eines Budgettyps',
   in_massnahme_typ_id                 VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Eindeutige ID eins Massnahmetyps',
   auftrag_typ_id                      INTEGER     COMMENT 'ID des Auftragstyps',
   psp_id                              INTEGER     COMMENT 'eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen',
   techn_platz_id                      VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Fachlicher Schlüssel des technischen Platzes aus tplnr. Referenz zur Tabelle techn_platz_per_2 (im Modell keine Darstellung der Beziehung) Wird compressed',
   werk_id                             INTEGER     COMMENT 'Numerischer Surrogate key für das Werk werks',
   phas_techn_abschluss_fg             INTEGER     NOT NULL COMMENT 'Flag = 1 bei technischem Abschluss. Quelle ist phas2',
   ref_objektart_id                    VARCHAR(2)       NOT NULL COLLATE 'en-ci' DEFAULT '  ' COMMENT 'Teilstring aus dem Quellfeld objnr. Das Feld setzt sich aus Teil 1 (char(2)) und Teil 2 (Auftragsnummer) zusammen. Hier wird nur der alpha-Teil gespeichert.',
   auftrag_kurztext                    VARCHAR(40)      COMMENT 'Kurzbeschreibung des Auftrags',
   referenz_auftrag_id                 VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Referenzauftragsnummer. If this order is derived from a previous order, then this is the ID of the previous order.',
   standort_id                         VARCHAR(10)      COLLATE 'en-ci' COMMENT 'ID eines Standortes. Zuordnung Markt bei Pooling-Geräten (oder alphanumerischer Wert / "POOL").',
   standort_werk_id                    INTEGER     COMMENT 'Numerischer Surrogate key für das Werk werks - Plan where order should have been executed. Most of the times it is identical to WERK_ID.',
   kostenstelle_id                     VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle, aus kostl.',
   verantw_arbeitsplatz_name           VARCHAR(10)      COMMENT 'Verantwortlicher Arbeitsplatz -  Main work center (SAP term)  for maintenance tasks. 
            A work center is an organizational unit_2 that defines where or by whom a maintenance activity is performed. Work centers can be machines, people, or production lines, for example.
            In this column we have the work center that is assigned to a maintenance order at the HEADER level (on position a.k.a. "order operation" level there can be other work centers).
            The "Name" is the identifier of the work place, there is no code or ID. The source system supports additional descriptions of these names, but they are not maintained by the business so as of May 2024, there is no lookup table with name-description combo',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_AUFTRAG PRIMARY KEY (auftrag_id, mandant_id) NOT ENFORCED
)  COMMENT = 'IMS - Auftragsstammdaten aus aufk';
