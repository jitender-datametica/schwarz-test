CREATE TABLE P_LEW_CORE.T_DESPATCH_ADVICE_2 (
   client_id                NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   loc_sid_wh               NUMBER(38,0)    NOT NULL COMMENT 'warehouse, foreign key on location_2',
   despatch_advice_id   	  NUMBER(38,0)    NOT NULL COMMENT 'row number of the WAWI source table T0020_DESPATCH_ADVICE_2 in the locasl WAWI system, pk together with client and warehouse',
   sup_sid                  NUMBER(38,0)    COMMENT 'Surrogate Key SUPPLIER_2',
   est_deliv_dt             DATE            COMMENT 'estimated delivery date',
   shipping_dt              DATE            COMMENT 'shipping date',
   despatch_advice_dt       DATE            COMMENT 'date of the despatch advice',
   dwh_load_id              NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created         		TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated        		TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_DESPATCH_ADVICE PRIMARY KEY (despatch_advice_id, loc_sid_wh)
       NOT enforced
)
COMMENT = '$Revision: 0000 $. despatch advices from supplieres for deliveries to warehouses
          Source: WAWI t0020_despatch_advice_2';