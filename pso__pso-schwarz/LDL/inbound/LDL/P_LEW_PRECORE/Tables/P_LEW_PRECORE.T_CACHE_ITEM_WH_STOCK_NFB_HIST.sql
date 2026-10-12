CREATE TABLE P_LEW_PRECORE.T_CACHE_ITEM_WH_STOCK_NFB_HIST
(
  CLIENT_ID           NUMBER(38)                    NOT NULL   COMMENT 'WDWH:client_id',
  LOC_SID             NUMBER(38)                    NOT NULL   COMMENT 'WDWH:SID des Artikels im DWH - Achtung!- Hier nicht Teil des Schlüssels, da u.U.zeitvolatil',
  ORIG_WH_NR          NUMBER(38)                    NOT NULL   COMMENT 'WDWH:wh_id',
  ITEM_SID            NUMBER(38)                    NOT NULL   COMMENT 'WDWH:SID der WH-Location im DWH - Achtung!- Hier nicht Teil des Schlüssels, aus Konsistenzgründen zur ITEM_SID',
  ORIG_ITEM_NR        NUMBER(38)                    NOT NULL   COMMENT 'WDWH:item_id',
  CASE_SIZE           NUMBER(38)                    NOT NULL   COMMENT 'WDWH:item_id',
  POS_NR              NUMBER(38)                    NOT NULL   COMMENT 'WDWH:pos_nr',
  POS_NR_LINK         NUMBER(38)                    NULL       COMMENT 'Referenz auf Posionsnummer WDWH:pos_nr_link',
  NFB_TYPE_CD         NUMBER(38)                    NOT NULL   COMMENT 'WDWH:nfb_type_cd',
  CASE_QTY            NUMBER(18,5)                  NULL       COMMENT 'mit hoher Wahrscheinlichkeit die Stückzahl f. case_size=1 sonst Preis eigentlich nicht anwendbar (falsch benannt?!); WDWH:qty_case_nfb',
  PRICE               NUMBER(18,5)                  NULL       COMMENT 'WDWH:price_retail',
  PRICE_NET           NUMBER(18,5)                  NULL       COMMENT 'WDWH:price_retail_net',
  VAT_TOTAL_VAL       NUMBER(18,5)                  NULL       COMMENT 'case_qty*price*[Masterdata].vat_pct/(100+[Masterdata].vat_pct); WDWH:val_vat',
  MODIFICATION_DT     DATE                          NULL       COMMENT 'WDWH:dat_modification',
  DELTA_DAY_DT        DATE                          NOT NULL   COMMENT 'fachliches Datum; WDWH:dat_formdate',
  DELETED_FG          NUMBER(38)                    NOT NULL   COMMENT 'Löschflag (0/1); Logische oder physische Löschung im Quellsystem oder fachlich interpretierte Löschung',
  DWH_VALID_FROM      DATE                          NOT NULL   COMMENT 'Datum der satzändernden WAWI-TEV (bei Änderung von Attributen); historisch-technischer Satzgültigkeitsstart: WDWH:dat_dayend',
  DWH_VALID_TO        DATE                          NOT NULL   COMMENT 'Vortag der ändernden WAWI-TEV (bei Änderung von Attributen); historisch-technisches Satzgültigkeitsende: WDWH:dat_dayend',
  DWH_LAST_CONFIRM_DT DATE                          NOT NULL   COMMENT 'Datum der satzliefernden WAWI-TEV (unabhängig von Änderungen von Attributen); letzte Bestätigung der Satzexistenz im Quellsystzem',
  DWH_LOAD_ID         NUMBER(38)                    NOT NULL   COMMENT 'technisch: Identifier des Ladelaufes der Einfügung oder letzten Änderung',
  DWH_CREATED         TIMESTAMP_NTZ(6)              NOT NULL   COMMENT 'Timestamp der Einfügung',
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NOT NULL   COMMENT 'Timestamp der letzten Änderung'/*,
  -- Current policy is not to create constraints.
  -- TD PK included here for information.
  CONSTRAINT CACHE_ITEM_WH_STOCK_NFB_HIST_PK PRIMARY KEY
  (
    CLIENT_ID,
    ORIG_WH_NR,
    ORIG_ITEM_NR,
    CASE_SIZE,
    POS_NR,
    DELTA_DAY_DT,
    DWH_VALID_FROM
  )*/
);