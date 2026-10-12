/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_auftrag
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_auftrag (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
reihe BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key. Original name - reihe'),
sendnr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - sendnr'),
auftyp STRING(1) OPTIONS(description='Task type. Original name - auftyp'),
aufstat STRING(2) OPTIONS(description='N/A. Original name - aufstat'),
anlagezeit DATETIME OPTIONS(description='Time stamp of the record creation. Original name - anlagezeit'),
abschlusszeit DATETIME
OPTIONS(description='Time stamp of the finished task. 19000101000000 if the task is not finished yet. Original name - abschlusszeit'),
von BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - von'),
zu BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - zu'),
kommreihe BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - kommreihe'),
kommreihenr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - kommreihenr'),
sammelnr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - sammelnr'),
filenr BIGNUMERIC(38,0) OPTIONS(description='FK: References LPV.HANDY.FILENR. Original name - filenr'),
auftr STRING(30) OPTIONS(description='N/A. Original name - auftr'),
posnr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - posnr'),
anr STRING(20) OPTIONS(description='Article number. FK: References LPV.AST.ANR. Original name - anr'),
charge STRING(30) OPTIONS(description='Batch. Original name - charge'),
wedatum DATE OPTIONS(description='Delivery date. Original name - wedatum'),
seriennr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - seriennr'),
menge BIGNUMERIC(38,0)
OPTIONS(description='Quantity (pcs) with 3 decimal places. Example: 500000 = 500 pcs. Original name - menge'),
menge_v BIGNUMERIC(38,0)
OPTIONS(description='Free quantity (pcs) with 3 decimal places. Example: 500000 = 500 pcs. Original name - menge_v'),
bhtid STRING(15) OPTIONS(description='N/A. Original name - bhtid'),
persnr STRING(9) OPTIONS(description='Personal number of the operator. Original name - persnr'),
prio BIGNUMERIC(38,0) OPTIONS(description='Priority. Original name - prio'),
bestandid STRING(20) OPTIONS(description='Surrogate key: Internal ID. Original name - bestandid'),
quelle STRING(11) OPTIONS(description='Source locaion. FK: References LPV.WHX.ORT. Original name - quelle'),
tpposdim1 BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - tpposdim1'),
tpposdim2 BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - tpposdim2'),
lhmnr STRING(30)
OPTIONS(description='Number of the pallet on which the stock is located. FK: References LPV.LHM.LHMNR and LPV.BEDSTAND.LHMNR. Original name - lhmnr'),
sektor BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - sektor'),
lagernr BIGNUMERIC(38,0)
OPTIONS(description='Source warehouse number, usually 1. FK: Referencing LPV.LAGER.LAGERNR. Original name - lagernr'),
bereich BIGNUMERIC(38,0) OPTIONS(description='Source area. FK: Referencing LPV.BEREICH.NR. Original name - bereich'),
opti BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - opti'),
ziel STRING(11) OPTIONS(description='Target locaion. FK: References LPV.WHX.ORT. Original name - ziel'),
ziel_tpposdim1 BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_tpposdim1'),
ziel_tpposdim2 BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_tpposdim2'),
ziel_lhmnr STRING(30) OPTIONS(description='N/A. Original name - ziel_lhmnr'),
ziel_sektor BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_sektor'),
ziel_lagernr BIGNUMERIC(38,0)
OPTIONS(description='Target warehouse number. FK: Referencing LPV.LAGER.LAGERNR. Original name - ziel_lagernr'),
ziel_bereich BIGNUMERIC(38,0)
OPTIONS(description='Target area. FK: Referencing LPV.BEREICH.NR. Original name - ziel_bereich'),
ziel_opti BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_opti'),
ziel_res BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_res'),
greifcolli BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - greifcolli'),
resbest BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - resbest'),
vpe BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - vpe'),
nextuse BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - nextuse'),
nextusekey STRING(50) OPTIONS(description='N/A. Original name - nextusekey'),
platznr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - platznr'),
bypass BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - bypass'),
zwischenziel STRING(11) OPTIONS(description='N/A. Original name - zwischenziel'),
zwischenlhm STRING(30) OPTIONS(description='N/A. Original name - zwischenlhm'),
waitfor BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - waitfor'),
waitforkey STRING(50) OPTIONS(description='N/A. Original name - waitforkey'),
llstransfer STRING(255) OPTIONS(description='N/A. Original name - llstransfer'),
reihenfolge BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - reihenfolge'),
vorzugsreihenfolge BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - vorzugsreihenfolge'),
greifcollivorschlagid BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - greifcollivorschlagid'),
wagewicht BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - wagewicht'),
ziel_rastermax BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_rastermax'),
arbeitsanwgrp BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - arbeitsanwgrp'),
ziel_vorgabe BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - ziel_vorgabe'),
originalbestandid STRING(20) OPTIONS(description='N/A. Original name - originalbestandid'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, reihe, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='LPV - This table saves goods movement tasks, pallets and items that are within the task, their type,timestamps creation, and finishing of the task as well as source and target locations.');