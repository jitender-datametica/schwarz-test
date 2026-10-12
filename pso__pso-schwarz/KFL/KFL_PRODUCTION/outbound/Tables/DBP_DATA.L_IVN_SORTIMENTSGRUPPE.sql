--==============================================================
-- Table: L_IVN_SORTIMENTSGRUPPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_SORTIMENTSGRUPPE
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ivn_sortimentsgruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ivn_sortimentsgruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kauflandweite eindeutige Nummer die eine IVN Segmentgruppe identifiziert'),
ivn_sortimentsgruppe_bez STRING(100) OPTIONS(description='Die Bezeichnung der IVN Segmentgruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ivn_sortimentsgruppe_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Die IVN-Sortimentgruppe teilt die Artikel in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern und verschiedenen IVN Gruppen vorkommt , sind aber unabhängig von IVN-Guppe und IVN-Verhandlungscluster.             Mandant ist nur aus technischer Notwendigkeit im PK !!!             Für jede Artikel-Lieferant-Land-Kombination kann nur eine IVN-Segmentgruppe zugeordnet werden.              ');