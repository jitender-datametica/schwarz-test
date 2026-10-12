CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_mes_prodfehler_1 (mandant_id, werk_id,
dat_schicht, schicht_id, mes_prodzeittyp_id, fehler_katalog_id, fehler_code_gruppe_id, fehler_code_id, dat_anfang,
zeit_anfang, dat_ende, zeit_ende, ist_fehler_dauer, ist_fehler_einh) AS SELECT V01.mandant_id,
 V02.flw_werk_id AS werk_id,
 V02.dat_schicht,
 V01.schicht_id,
 V01.mes_prodzeittyp_id,
 V01.fehler_katalog_id,
 V01.fehler_code_gruppe_id,
 V01.fehler_code_id,
 DATE(V01.datzeit_anfang) AS dat_anfang,
 TIME(V01.datzeit_anfang) AS zeit_anfang,
 DATE(V01.datzeit_ende) AS dat_ende,
 TIME(V01.datzeit_ende) AS zeit_ende,
 V01.ist_fehler_dauer,
 V01.ist_fehler_einh
FROM kfl_production_dbp_view.v_flw_mes_prodfehler_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_mes_schicht_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.schicht_id = V02
   .schicht_id;