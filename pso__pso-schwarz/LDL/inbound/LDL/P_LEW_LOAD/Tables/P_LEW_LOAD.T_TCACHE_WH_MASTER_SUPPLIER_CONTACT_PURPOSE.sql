CREATE TABLE P_LEW_LOAD.T_TCACHE_WH_MASTER_SUPPLIER_CONTACT_PURPOSE (
  client_id                     NUMBER(38,0) NOT NULL COMMENT 'Länderkennung DWH',
  wh_id                         NUMBER(38,0) NOT NULL COMMENT 'Warehouse Kennung',
  sup_contact_purpose_id        NUMBER(38,0) NOT NULL COMMENT 'surrogate key for the contact purpose from WAWI t_244_contact_type.',
  sup_contact_purpose_descr     VARCHAR(100) COMMENT 'international description of the contact purpose from WAWI t_244_contact_type',
  dwh_load_id                   NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
  dwh_created                   TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
  dwh_updated                   TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_SUPPLIER_CONTACT_PURP PRIMARY KEY (sup_contact_purpose_descr, sup_contact_purpose_id )
       NOT enforced
)
COMMENT = '$Revision: 0000 $. temporary cache table for load into t_supplier_contact_hist';