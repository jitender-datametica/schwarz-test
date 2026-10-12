--==============================================================
-- Table: L_IVN_SORTIMENTSGRUPPE
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_SORTIMENTSGRUPPE
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_IVN_SORTIMENTSGRUPPE (
   MANDANT_ID                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   IVN_SORTIMENTSGRUPPE_ID             NUMBER(38,0)     NOT NULL COMMENT 'Kauflandweite eindeutige Nummer die eine IVN Segmentgruppe identifiziert',
   IVN_SORTIMENTSGRUPPE_BEZ            VARCHAR(100)     COMMENT 'Die Bezeichnung der IVN Segmentgruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_IVN_SORTIMENTSGRUPPE PRIMARY KEY (IVN_SORTIMENTSGRUPPE_ID, MANDANT_ID) NOT ENFORCED
)  COMMENT = 'Die IVN-Sortimentgruppe teilt die Artikel in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern und verschiedenen IVN Gruppen vorkommt , sind aber unabhängig von IVN-Guppe und IVN-Verhandlungscluster.
             Mandant ist nur aus technischer Notwendigkeit im PK !!!
             Für jede Artikel-Lieferant-Land-Kombination kann nur eine IVN-Segmentgruppe zugeordnet werden. 
             ';
