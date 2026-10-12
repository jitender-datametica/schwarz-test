--==============================================================
-- Table: transportation_unit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_1
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:27:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_id_ext STRING(20) COLLATE 'und:ci' OPTIONS(description='Transporteinheit (extern)'),
lime_id STRING(32) OPTIONS(description='GUID Lokation'),
lime_id_ausgepackt STRING(32) OPTIONS(description='GUID Handling Unit_1 (unpacked)'),
handling_unit_guid STRING(32) OPTIONS(description='GUID Handling Unit_1'),
transportmittel STRING(10) COLLATE 'und:ci' OPTIONS(description='Transportmittel'),
eigentuemer STRING(10) COLLATE 'und:ci' OPTIONS(description='Eigentümer'),
frachtfuehrer STRING(10) COLLATE 'und:ci' OPTIONS(description='Frachtführer'),
scac STRING(4) COLLATE 'und:ci' OPTIONS(description='Standard Carrier Alpha Code'),
max_anz_siegel BIGNUMERIC(38,0) OPTIONS(description='Max. Anzahl Siegel'),
fahrzeugnummer_intern STRING(20) COLLATE 'und:ci' OPTIONS(description='Interne Fahrzeugnummer'),
land_kfz_kennzeichen STRING(3) COLLATE 'und:ci' OPTIONS(description='Länderkennzeichen'),
kfz_kennzeichen STRING(20) COLLATE 'und:ci' OPTIONS(description='KFZ-Kennzeichen'),
tu_permanent_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: permanente Transporteinheit'),
tu_head_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: TU-Head'),
tor_vorbeladen_fg STRING(1) OPTIONS(description='Flag: Tour_1 muss vorbeladen sein'),
lkw_vorgekuehlt_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: LKW muss vorgekühlt werden'),
rundlauf_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: Rundlauf-Tour_1'),
hu_gewicht NUMERIC(15,3) OPTIONS(description='HU-Gewicht'),
hu_gewicht_menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='HU-Gewichtseinheit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit) NOT ENFORCED
) OPTIONS(description='Transportation Unit_1');