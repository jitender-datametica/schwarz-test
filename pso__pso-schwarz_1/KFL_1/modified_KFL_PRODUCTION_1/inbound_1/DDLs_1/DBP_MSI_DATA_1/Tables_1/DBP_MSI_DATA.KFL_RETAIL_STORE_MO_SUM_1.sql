--==============================================================
-- Table: kfl_retail_store_mo_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kfl_retail_store_mo_sum_1
   generated from Powerdesigner on Dienstag, 13. Februar 2024 18:32:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.KFL_RETAIL_STORE_MO_SUM_1 (
   mandant_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL DEFAULT -1 COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat_1 eines Kalenderjahres, Format JJJJMM',
   anz_review_rating                   INTEGER     COMMENT 'Anzahl der im Monat_1 X erstellten Bewertungen',
   sum_review_rating                   NUMBER(29,5)     COMMENT 'Gesamtzahl der Sterne, die in den Bewertungen im Monat_1 X vergeben wurden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KFL_RETAIL_STORE_MO_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, kjmo) NOT ENFORCED
)  COMMENT = 'Aggregationstabelle mit Kennzahlen auf Ebene Mandant_1, Markt und Monat_1 der Kaufland-Bewertungen. Es ist eine_1 periodische Snapshot_1-Tabelle, die zu Anfang jeden Monats ein Abzug der Datensätze die im Vormonat erstellt wurde, von der Quelltabelle(dbp.data.retail_store_customer_review_1) in die Zieltabelle geschrieben werden. Dadurch ergibt sich mit der Zeit_1 eine_1 Art_1 monatliche aggregierte Historie in der Zieltabelle. ';
