CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_dv_carrierlayer_trackandtrace (
carrier STRING(500),
trackingid STRING(500),
huid BIGNUMERIC(38,0),
carrierproductid STRING(50),
shipmentdirection STRING(50),
returnrequest STRING(50),
filename STRING(500),
extraction_timestamp DATETIME
);