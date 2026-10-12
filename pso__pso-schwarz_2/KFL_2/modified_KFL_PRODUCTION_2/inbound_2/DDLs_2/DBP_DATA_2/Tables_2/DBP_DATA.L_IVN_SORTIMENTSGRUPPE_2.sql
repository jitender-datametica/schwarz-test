--==============================================================
-- Table: L_IVN_SORTIMENTSGRUPPE_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL FOR TABLE: L_IVN_SORTIMENTSGRUPPE_2
   GENERATED FROM POWERDESIGNER ON Montag, 25. September 2023 14:25:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_IVN_SORTIMENTSGRUPPE_2 (
   MANDANT_ID                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   IVN_SORTIMENTSGRUPPE_ID             INTEGER     NOT NULL COMMENT 'Kauflandweite eindeutige Nummer die eine_2 IVN Segmentgruppe identifiziert',
   IVN_SORTIMENTSGRUPPE_BEZ            VARCHAR(100)     COMMENT 'Die Bezeichnung der IVN Segmentgruppe',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_IVN_SORTIMENTSGRUPPE PRIMARY KEY (IVN_SORTIMENTSGRUPPE_ID, MANDANT_ID) NOT ENFORCED
)  COMMENT = 'Die IVN-Sortimentgruppe teilt die Artikel_2 in Gruppen ein die in verschiedenen IVN-Verhandlungsclustern und verschiedenen IVN Gruppen vorkommt , sind aber unabhängig von IVN-Guppe und IVN-Verhandlungscluster.
             Mandant_2 ist nur aus technischer Notwendigkeit im PK !!!
             Für jede Artikel_2-Lieferant-Land_2-Kombination kann nur eine_2 IVN-Segmentgruppe zugeordnet werden. 
             ';
