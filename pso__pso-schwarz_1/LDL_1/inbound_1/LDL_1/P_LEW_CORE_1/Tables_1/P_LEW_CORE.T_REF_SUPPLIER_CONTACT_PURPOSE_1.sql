CREATE TABLE P_LEW_CORE.T_REF_SUPPLIER_CONTACT_PURPOSE_1 (
   sup_contact_purpose_sid         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key for the contact_1 purpose from WAWI t_244_contact_type.',
   sup_contact_purpose_descr       VARCHAR(100)    COMMENT 'international description of the contact_1 purpose from WAWI t_244_contact_type',
   dwh_load_id                     NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                     TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                     TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_SUPPLIER_CONTACT_PURP PRIMARY KEY (sup_contact_purpose_sid)
       NOT enforced
)
COMMENT = '$Revision: 0000 $. table contains purposes of supplier_1 contacts
          Source: WAWI table t244_contact_type. This table contains the same information in every country_1, but the technical identifier can be differ from country_1 to country. 
          Therefore the information key is used to derive a sid.';