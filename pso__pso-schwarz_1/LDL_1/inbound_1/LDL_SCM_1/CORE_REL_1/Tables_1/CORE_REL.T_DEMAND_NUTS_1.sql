  CREATE TABLE CORE_REL.T_DEMAND_NUTS_1
  (
    IAN NUMBER(38,0) COMMENT 'Kennung für den Artikel_1',
    PAL_ARTIKEL VARCHAR(100) COMMENT 'Artikelkennung in Palette',
    STUECK_JE_KARTON NUMBER(38,0) COMMENT 'Anzahl der Stücke pro Karton',
    STUECK_JE_PALETTE NUMBER(38,0) COMMENT 'Anzahl der Stücke pro Palette',
    LAND_1 VARCHAR(100) COMMENT 'Ländercode oder -name',
    MONTH NUMBER(2,0) COMMENT 'Monat_1 der Daten (1-12)',
    YEAR NUMBER(4,0) COMMENT 'Jahr der Daten (z.B. 2024)',
    PLAN NUMBER(38,5) COMMENT 'Geplante Menge',
    BESTELLMENGE NUMBER(38,0) COMMENT 'Bestellmenge',
    D_BM_VS_PLAN NUMBER(38,5) COMMENT 'Absolute Differenz zwischen Bestellmenge und geplanter Menge',
    D_BM_VS_PLAN_P NUMBER(38,5) COMMENT 'Prozentuale Differenz zwischen Bestellmenge und geplanter Menge',
    DWH_UPDATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Erstellungszeitpunkt des Datensatzes im DWH.',
    DWH_CREATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Zeitstempel der letzten Aktualisierung des Datensatzes im DWH.'
  );