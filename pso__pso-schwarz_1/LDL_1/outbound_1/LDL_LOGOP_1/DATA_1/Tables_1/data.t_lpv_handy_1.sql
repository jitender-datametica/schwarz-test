/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_lpv_handy_1
Description		|	LPV source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_handy_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'),
filenr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Internal ID. FK: References LPV.AUFTRAG.FILENR. Original name - filenr'),
typ STRING(1) OPTIONS(description='Task type. Original name - typ'),
anlagezeit DATETIME OPTIONS(description='Time stamp of the record creation. Original name - anlagezeit'),
startzeit DATETIME OPTIONS(description='Time stamp of the task activation. Original name - startzeit'),
abschlusszeit DATETIME OPTIONS(description='Time stamp of the finished task. Original name - abschlusszeit'),
status_1 BIGNUMERIC(38,0) OPTIONS(description='Status_1 of the task. Original name - status_1'),
prio BIGNUMERIC(38,0) OPTIONS(description='Priority. Original name - prio'),
lagernr BIGNUMERIC(38,0)
OPTIONS(description='Source warehouse number, usually 1. FK: Referencing LPV.LAGER.LAGERNR. Original name - lagernr'),
bereich BIGNUMERIC(38,0) OPTIONS(description='Source area. FK: Referencing LPV.BEREICH.NR. Original name - bereich'),
ziel_lagernr BIGNUMERIC(38,0)
OPTIONS(description='Target warehouse number. FK: Referencing LPV.LAGER.LAGERNR. Original name - ziel_lagernr'),
ziel_bereich BIGNUMERIC(38,0)
OPTIONS(description='Target area. FK: Referencing LPV.BEREICH.NR. Original name - ziel_bereich'),
anzahl BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - anzahl'),
bhtid STRING(15) OPTIONS(description='N/A. Original name - bhtid'),
persnr STRING(9) OPTIONS(description='Personal number of the operator. Original name - persnr'),
persnrpano STRING(9) OPTIONS(description='N/A. Original name - persnrpano'),
persnrpasp STRING(9) OPTIONS(description='N/A. Original name - persnrpasp'),
tour_1 BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - tour_1'),
variant STRING(100) OPTIONS(description='N/A. Original name - variant'),
anz_colli BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - anz_colli'),
anz_pal BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - anz_pal'),
bexnr STRING(20) OPTIONS(description='N/A. Original name - bexnr'),
dummy_1 STRING(150) OPTIONS(description='N/A. Original name - dummy_1'),
versandart BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - versandart'),
sammelfnr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - sammelfnr'),
platznr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - platznr'),
lhmnr STRING(30)
OPTIONS(description='Number of the pallet on which the stock is located. FK: References LPV.LHM.LHMNR and LPV.BEDSTAND.LHMNR. Original name - lhmnr'),
arbeitsart BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - arbeitsart'),
mfrkz BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - mfrkz'),
gedruckt BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - gedruckt'),
weggrp0status BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - weggrp0status'),
weggrp1status BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - weggrp1status'),
weggrp2status BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - weggrp2status'),
weggrp3status BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - weggrp3status'),
weggrp4status BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - weggrp4status'),
gruppenr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - gruppenr'),
vongruppenr BIGNUMERIC(38,0) OPTIONS(description='N/A. Original name - vongruppenr'),
subtyp STRING(10) OPTIONS(description='N/A. Original name - subtyp'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, filenr, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='LPV - This table saves goods movement tasks, their type, status_1 and timestamps creation, activation and finishing of the task.');