CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_objekt_adresse_zu_per_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'), tp_objekt_id
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'), werk_id
OPTIONS(description='Numerischer Surrogate key für das Werk'), standort_id
OPTIONS(description='ID eines Standorts. Entspricht bei Bestandsmärkten der Marktnummer,  bei zukünftigen Standorten eine_1 Nummer bzw. bei Dummy_1-Standorten XXXX'),
tp_objekt_sort_id OPTIONS(description='Equipment - Sortierfeld'), dat_von
OPTIONS(description='Datum (von) - Date when record became valid'), dat_bis
OPTIONS(description='Datum (bis) - Date when record expired, and is no logner valid'), instandhaltung_werk_id
OPTIONS(description='Numerischer Surrogate key für das Werk werks. Plant where the equipment should be serviced. e. g. small fork lifters used in the stores are taken to the DCs for maintenance+repairs.'))
OPTIONS(DESCRIPTION = `ADRESSDATEN ZUM EQUIPMENT AUS SAP INDUSTRY (TABELLE EQUI_ADDR)`) AS SELECT mandant_id,
 tp_objekt_id,
 werk_id,
 standort_id,
 tp_objekt_sort_id,
 dat_von,
 dat_bis,
 instandhaltung_werk_id
FROM kfl_production_dbp_data.tp_objekt_adresse_zu_per_1;