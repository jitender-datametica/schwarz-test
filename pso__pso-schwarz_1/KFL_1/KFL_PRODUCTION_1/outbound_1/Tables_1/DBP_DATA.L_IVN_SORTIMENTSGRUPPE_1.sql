--==============================================================
-- Table: L_IVN_SORTIMENTSGRUPPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_SORTIMENTSGRUPPE_1
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ivn_sortimentsgruppe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ivn_sortimentsgruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kauflandweite eindeutige Nummer die eine_1 IVN Segmentgruppe identifiziert'),
ivn_sortimentsgruppe_bez STRING(100) OPTIONS(description='Die Bezeichnung der IVN Segmentgruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ivn_sortimentsgruppe_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Die IVN-Sortimentgruppe teilt die Artikel_1 in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern und verschiedenen IVN Gruppen vorkommt , sind aber unabhängig von IVN-Guppe und IVN-Verhandlungscluster.             Mandant_1 ist nur aus technischer Notwendigkeit im PK !!!             Für jede Artikel_1-Lieferant-Land_1-Kombination kann nur eine_1 IVN-Segmentgruppe zugeordnet werden.              ');