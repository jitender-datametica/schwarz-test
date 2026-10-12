CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
transportation_unit_id OPTIONS(description='Transporteinheit (intern)'), kj_transportation_unit
OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_id_ext
OPTIONS(description='Transporteinheit (extern)'), lime_id OPTIONS(description='GUID Lokation'), lime_id_ausgepackt
OPTIONS(description='GUID Handling Unit_1 (unpacked)'), handling_unit_guid OPTIONS(description='GUID Handling Unit_1'),
transportmittel OPTIONS(description='Transportmittel'), eigentuemer OPTIONS(description='Eigentümer'), frachtfuehrer
OPTIONS(description='Frachtführer'), scac OPTIONS(description='Standard Carrier Alpha Code'), max_anz_siegel
OPTIONS(description='Max. Anzahl Siegel'), fahrzeugnummer_intern OPTIONS(description='Interne Fahrzeugnummer'),
land_kfz_kennzeichen OPTIONS(description='Länderkennzeichen'), kfz_kennzeichen OPTIONS(description='KFZ-Kennzeichen'),
tu_permanent_fg OPTIONS(description='Flag: permanente Transporteinheit'), tu_head_fg
OPTIONS(description='Flag: TU-Head'), tor_vorbeladen_fg OPTIONS(description='Flag: Tour_1 muss vorbeladen sein'),
lkw_vorgekuehlt_fg OPTIONS(description='Flag: LKW muss vorgekühlt werden'), rundlauf_fg
OPTIONS(description='Flag: Rundlauf-Tour_1'), hu_gewicht OPTIONS(description='HU-Gewicht'), hu_gewicht_menge_einh_id
OPTIONS(description='HU-Gewichtseinheit'), td_update
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'))
OPTIONS(DESCRIPTION = `TRANSPORTATION UNIT_1`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_id_ext,
 lime_id,
 lime_id_ausgepackt,
 handling_unit_guid,
 transportmittel,
 eigentuemer,
 frachtfuehrer,
 scac,
 max_anz_siegel,
 fahrzeugnummer_intern,
 land_kfz_kennzeichen,
 kfz_kennzeichen,
 tu_permanent_fg,
 tu_head_fg,
 tor_vorbeladen_fg,
 lkw_vorgekuehlt_fg,
 rundlauf_fg,
 hu_gewicht,
 hu_gewicht_menge_einh_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.transportation_unit_1;