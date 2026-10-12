/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wamas_tpap_1
Description		|	WAMAS source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wamas_tpap_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(4) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source_system: LPV'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
tanr FLOAT64 NOT NULL OPTIONS(description='Transport order number'),
posnr FLOAT64 NOT NULL OPTIONS(description='Transport order position number'),
protnr FLOAT64 OPTIONS(description='Protocol number'),
teid STRING(18) OPTIONS(description='TE-ID'),
ksnr FLOAT64 OPTIONS(description='Picklistnumber (WAMAS)'),
vplpidx FLOAT64 OPTIONS(description='VPLP Index'),
cmd STRING(6) OPTIONS(description='TPAP-Command'),
bearbid_posnr FLOAT64 OPTIONS(description='Position number'),
bearbid_mandant STRING(3) OPTIONS(description='Mandant_1'),
bearbid_bearbnr STRING(16) OPTIONS(description='Edit number'),
bearbid_bearbkz STRING(5) OPTIONS(description='End indicator'),
bearbid_bearbtyp STRING(3) OPTIONS(description='Edit type'),
matid_artid_mandant STRING(3) OPTIONS(description='Mandant_1'),
artikelnr STRING(20) OPTIONS(description='Product number. Original name: matid_artid_artnr'),
matid_artid_variante STRING(4) OPTIONS(description='Variant'),
matid_charge STRING(20) OPTIONS(description='Charge'),
artbez STRING(35) OPTIONS(description='Product description'),
intartbez STRING(35) OPTIONS(description='International product description'),
veeinheit STRING(3) OPTIONS(description='Unit_1 of EVE'),
heeinheit STRING(3) OPTIONS(description='Unit_1 of HE'),
le2einheit STRING(3) OPTIONS(description='Unit_1 of LE2'),
le3einheit STRING(3) OPTIONS(description='Unit_1 of LE3'),
teeinheit STRING(3) OPTIONS(description='Unit_1 of TE'),
vonmngs_mng FLOAT64 OPTIONS(description='Quantity'),
vonmngs_vehefakt FLOAT64 OPTIONS(description='EVE/HE'),
vonmngs_hele2fakt FLOAT64 OPTIONS(description='HE/LE2'),
vonmngs_hele3fakt FLOAT64 OPTIONS(description='HE/LE3'),
vonmngs_hetefakt FLOAT64 OPTIONS(description='HE/TE'),
vonmngs_gewicht FLOAT64 OPTIONS(description='Weight'),
info STRING(70) OPTIONS(description='Information'),
endhoststatus STRING(6) OPTIONS(description='End HOSTSTATUS'),
acode STRING(2) OPTIONS(description='End code'),
laghost STRING(4) OPTIONS(description='Storage location_1 host'),
hist_anzeit DATE OPTIONS(description='Created on'),
hist_anuser STRING(10) OPTIONS(description='Created from'),
hist_aezeit DATE OPTIONS(description='Changed on'),
hist_aeuser STRING(10) OPTIONS(description='Changed from'),
hist_lozeit DATE OPTIONS(description='Deletion on'),
hist_louser STRING(10) OPTIONS(description='Deleted from'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted')
) OPTIONS(description='WAMAS - Transport order POSITION');