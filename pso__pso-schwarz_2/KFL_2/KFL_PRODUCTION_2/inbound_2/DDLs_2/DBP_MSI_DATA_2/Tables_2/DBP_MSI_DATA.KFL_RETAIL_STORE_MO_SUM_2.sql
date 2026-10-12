--==============================================================
-- Table: kfl_retail_store_mo_sum_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kfl_retail_store_mo_sum_2
   generated from Powerdesigner on Dienstag, 13. Februar 2024 18:32:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.KFL_RETAIL_STORE_MO_SUM_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Monat_2 eines Kalenderjahres, Format JJJJMM',
   anz_review_rating                   NUMBER(38,0)     COMMENT 'Anzahl der im Monat_2 X erstellten Bewertungen',
   sum_review_rating                   NUMBER(38,5)     COMMENT 'Gesamtzahl der Sterne, die in den Bewertungen im Monat_2 X vergeben wurden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KFL_RETAIL_STORE_MO_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, kjmo) NOT ENFORCED
)  COMMENT = 'Aggregationstabelle mit Kennzahlen auf Ebene Mandant_2, Markt und Monat_2 der Kaufland-Bewertungen. Es ist eine_2 periodische Snapshot_2-Tabelle, die zu Anfang jeden Monats ein Abzug der Datensätze die im Vormonat erstellt wurde, von der Quelltabelle(dbp.data.retail_store_customer_review_2) in die Zieltabelle geschrieben werden. Dadurch ergibt sich mit der Zeit_2 eine_2 Art_2 monatliche aggregierte Historie in der Zieltabelle. ';
