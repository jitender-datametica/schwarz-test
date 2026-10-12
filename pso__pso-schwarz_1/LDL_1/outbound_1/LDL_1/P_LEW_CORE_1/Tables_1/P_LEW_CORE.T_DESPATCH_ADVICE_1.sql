CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_despatch_advice_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse, foreign key on location_1'),
despatch_advice_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='row number of the WAWI source table T0020_DESPATCH_ADVICE_1 in the locasl WAWI system, pk together with client and warehouse'),
sup_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key SUPPLIER_1'),
est_deliv_dt DATE OPTIONS(description='estimated delivery date'),
shipping_dt DATE OPTIONS(description='shipping date'),
despatch_advice_dt DATE OPTIONS(description='date of the despatch advice'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (despatch_advice_id, loc_sid_wh) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. despatch advices from supplieres for deliveries to warehouses          Source: WAWI t0020_despatch_advice_1');