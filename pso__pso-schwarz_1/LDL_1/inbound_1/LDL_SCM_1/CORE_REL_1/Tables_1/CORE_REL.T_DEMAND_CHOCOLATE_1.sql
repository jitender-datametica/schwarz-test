 CREATE TABLE CORE_REL.T_DEMAND_CHOCOLATE_1  
  (
    IAN NUMBER(38,0) COMMENT 'IAN',
    MAT_NR NUMBER(38,0) COMMENT 'Materialnummer',
    PAL_ARTIKEL VARCHAR(100) COMMENT 'PAL Artikel_1',
    STUECK_JE_KARTON VARCHAR(100) COMMENT 'Stück pro Karton',
    STUECK_JE_PALETTE NUMBER(38,0) COMMENT 'Stück pro Palette',
    LAND_1 VARCHAR(100) COMMENT 'Land_1',
    MONTH NUMBER(2,0) COMMENT 'Monat_1',
    YEAR NUMBER(4,0) COMMENT 'Jahr',
    PLAN NUMBER(38,5) COMMENT 'Geplante Menge',
    BESTELLMENGE NUMBER(38,0) COMMENT 'Erhaltene Menge',
    D_BM_VS_PLAN NUMBER(38,5) COMMENT 'Differenz zwischen Bestellmenge und geplanter Menge (absolut)',
    D_BM_VS_PLAN_P NUMBER(38,5) COMMENT 'Differenz zwischen Bestellmenge und geplanter Menge (prozentual)',
    DWH_UPDATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Erstellungszeitpunkt des Datensatzes im DWH',
    DWH_CREATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Zeitstempel der letzten Aktualisierung des Datensatzes im DWH'
  );