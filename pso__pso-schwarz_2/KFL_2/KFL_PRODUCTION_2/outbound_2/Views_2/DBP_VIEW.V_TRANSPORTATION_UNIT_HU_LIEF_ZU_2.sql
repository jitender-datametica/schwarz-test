CREATE OR REPLACE VIEW kfl_production_dbp_view.v_transportation_unit_hu_lief_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), transportation_unit_id OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit OPTIONS(description='Anlagejahr der Transporteinheit'), transportation_unit_sr_act_id
OPTIONS(description='transportation_unit_sr_act_id'), transportation_unit_seq_id
OPTIONS(description='Reihenfolgenummer'), compartment_hu_guid OPTIONS(description='GUID Handling Unit_2 (Fach)'),
ladeposition OPTIONS(description='Postion am Fahrzeug / Transporteinheit'), lagernummer_id
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'), beleg_guid
OPTIONS(description='Beleg-ID'), beleg_pos_guid OPTIONS(description='Positions-ID'), belegtyp_id
OPTIONS(description='Belegtyp'), beleg_id OPTIONS(description='Belegnummer'), beleg_pos_id
OPTIONS(description='Positionsnummer'), zuordnungsart_id OPTIONS(description='Zuordnungsart'), top_hu_guid
OPTIONS(description='GUID Handling Unit_2 (Top)'), top_hu_id OPTIONS(description='HUIDENT Handling Unit_2 (Top)'),
cross_hu_fg OPTIONS(description='Flag: Lieferübergreifende HU'), change_fg
OPTIONS(description='Flag: Änderungsindikator'), status_fg OPTIONS(description='Flag: Status_2'), datzeit_erstellung
OPTIONS(description='Erstellungszeitpunkt'), datzeit_aenderung OPTIONS(description='Änderungszeitpunkt'),
auslieferung_exist_fg OPTIONS(description='Flag: Status_2 "Auslieferung existiert"'))
OPTIONS(DESCRIPTION = `TRANSPORTATION UNIT_2, HU, DELIVERY`) AS SELECT mandant_id,
 transportation_unit_id,
 kj_transportation_unit,
 transportation_unit_sr_act_id,
 transportation_unit_seq_id,
 compartment_hu_guid,
 ladeposition,
 lagernummer_id,
 beleg_guid,
 beleg_pos_guid,
 belegtyp_id,
 beleg_id,
 beleg_pos_id,
 zuordnungsart_id,
 top_hu_guid,
 top_hu_id,
 cross_hu_fg,
 change_fg,
 status_fg,
 datzeit_erstellung,
 datzeit_aenderung,
 auslieferung_exist_fg
FROM kfl_production_dbp_data.transportation_unit_hu_lief_zu_2;