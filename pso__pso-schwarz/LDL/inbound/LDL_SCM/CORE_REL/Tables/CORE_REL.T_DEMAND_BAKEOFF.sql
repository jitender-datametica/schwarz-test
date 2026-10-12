CREATE TABLE CORE_REL.T_DEMAND_BAKEOFF
  (
    IAN NUMBER(38,0) COMMENT 'Internationale Artikelnummer',
    PROD_HIER_V VARCHAR(100) COMMENT 'Produkthierarchie',
    STUECK_JE_KARTON NUMBER(38,0) COMMENT 'Stück pro Karton',
    STUECK_JE_HHPECH NUMBER(38,0) COMMENT 'Stück je HHPECH',
    LAND VARCHAR(100) COMMENT 'Ländercode',
    MONTH NUMBER(2,0) COMMENT 'Monat',
    YEAR NUMBER(4,0) COMMENT 'Jahr',
    PLAN NUMBER(38,5) COMMENT 'Plan',
    BESTELLMENGE NUMBER(38,0) COMMENT 'Bestellmenge',
    D_BM_VS_PLAN NUMBER(38,5) COMMENT 'Differenz zwischen Bestellmenge und Plan',
    D_BM_VS_PLAN_P NUMBER(38,5) COMMENT 'Prozentuale Differenz zwischen Bestellmenge und Plan',
    DWH_UPDATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Erstellungszeitpunkt des Datensatzes im DWH',
    DWH_CREATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Zeitstempel der letzten Aktualisierung des Datensatzes im DWH'
  );