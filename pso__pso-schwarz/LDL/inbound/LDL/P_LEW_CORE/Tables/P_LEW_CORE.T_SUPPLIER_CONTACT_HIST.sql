CREATE TABLE P_LEW_CORE.T_SUPPLIER_CONTACT_HIST (
   client_id                      NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid_wh                     NUMBER(38,0)    NOT NULL COMMENT 'warehouse, foreign key on location',
   sup_contact_id                 NUMBER(12,0)    NOT NULL COMMENT 'ID from WAWI source table t246_contact_supplier, pk together with client and warehouse',
   sup_sid                        NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key SUPPLIER',
   sup_contact_purpose_sid        NUMBER(38,0)    COMMENT 'surrogate key for the contact purpose from WAWI t_244_contact_type.',
   contact_medium_cd    	      VARCHAR(5)      COLLATE 'en-ci' NOT NULL COMMENT 'id of the media code, links to the  contact medium reference table',
   contact_preference_fg          NUMBER(38,0)    COMMENT 'preference of the contact method: 1 - prefered, 0 - not prefered',
   contact_active_fg              NUMBER(38,0)    COMMENT '0=not active, 1=active',
   contact_last_changed_dt        DATE            COMMENT 'date of the last change of the contact information',
   deleted_fg                     NUMBER(38,0)    NOT NULL COMMENT 'attribute set was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                 DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 1900-01-01 ("minus unendlich")',
   dwh_valid_to                   DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 9999-12-31 ("plus unendlich")',
   dwh_load_id                    NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_SUPPLIER_CONTACT_HIST PRIMARY KEY (sup_contact_id, loc_sid_wh, dwh_valid_from)
       NOT enforced
)
COMMENT = '$Revision: 0000 $. table contains contact informaton for suppliers
          source: WAWI table t246_contact_supplier';