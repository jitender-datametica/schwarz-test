CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_mes_prodfehler_1 AS SELECT mandant_id,
 schicht_id,
 mes_prodzeittyp_id,
 fehler_katalog_id,
 fehler_code_gruppe_id,
 fehler_code_id,
 datzeit_anfang,
 datzeit_ende,
 ist_fehler_dauer,
 ist_fehler_einh
FROM kfl_production_dbp_data.flw_mes_prodfehler_1;