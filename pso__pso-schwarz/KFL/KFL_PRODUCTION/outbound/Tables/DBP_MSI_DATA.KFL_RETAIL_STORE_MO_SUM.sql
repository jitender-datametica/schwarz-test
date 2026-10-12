--==============================================================
-- Table: kfl_retail_store_mo_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kfl_retail_store_mo_sum
   generated from Powerdesigner on Dienstag, 13. Februar 2024 18:32:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.kfl_retail_store_mo_sum (
mandant_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
anz_review_rating BIGNUMERIC(38,0) OPTIONS(description='Anzahl der im Monat X erstellten Bewertungen'),
sum_review_rating BIGNUMERIC(38,5)
OPTIONS(description='Gesamtzahl der Sterne, die in den Bewertungen im Monat X vergeben wurden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kjmo) NOT ENFORCED
)
OPTIONS(description='Aggregationstabelle mit Kennzahlen auf Ebene Mandant, Markt und Monat der Kaufland-Bewertungen. Es ist eine periodische Snapshot-Tabelle, die zu Anfang jeden Monats ein Abzug der Datensätze die im Vormonat erstellt wurde, von der Quelltabelle(dbp.data.retail_store_customer_review) in die Zieltabelle geschrieben werden. Dadurch ergibt sich mit der Zeit eine Art monatliche aggregierte Historie in der Zieltabelle. ');