  CREATE TABLE CORE_REL.T_DEMAND_ICE_2
  (
    PAL_IAN_LIDL NUMBER(38,0) COMMENT 'PAL IAN Lidl',
    ARTIKELBEZEICHNUNG VARCHAR(500) COMMENT 'Artikelbeschreibung',
    LAND_2 VARCHAR(100) COMMENT 'Land_2',
    EINZELSTUECK_PRO_FSSCHALE NUMBER(38,0) COMMENT 'Stück pro Eisschale',
    FSSCHALEN_PRO_PAL NUMBER(38,0) COMMENT 'Schalen pro Palette',
    GESAMT_PLANME_IN_FS_SCHALEN NUMBER(38,0) COMMENT 'Gesamtplanung in Eisschalen',
    MONTH NUMBER(2,0) COMMENT 'Monat_2',
    YEAR NUMBER(4,0) COMMENT 'Jahr',
    PLAN NUMBER(38,5) COMMENT 'Plan',
    BM NUMBER(38,5) COMMENT 'Bestellmenge',
    D_BM_VS_PLAN_ABS NUMBER(38,5) COMMENT 'Differenz zwischen Bestellmenge und geplanter Menge (absolut)',
    D_BM_VS_PLAN_P NUMBER(38,5) COMMENT 'Differenz zwischen Bestellmenge und geplanter Menge (prozentual)',
    DWH_UPDATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Erstellungszeitpunkt des Datensatzes im DWH',
    DWH_CREATED_TMSP TIMESTAMP_NTZ(6) COMMENT 'Zeitstempel der letzten Aktualisierung des Datensatzes im DWH'
  );