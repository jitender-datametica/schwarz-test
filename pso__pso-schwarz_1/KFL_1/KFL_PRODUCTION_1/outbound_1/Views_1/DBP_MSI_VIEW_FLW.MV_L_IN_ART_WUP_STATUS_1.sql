CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_art_wup_status_1 (mandant_id, in_art_id, werk_id,
dme_einh_id, tiergattung_id, beschaffungsart_id, zerlege_gruppe_id, loesch_id, dat_von_loesch_id, indentifikation_fg,
tierkategorie_id, herkunftsnachweis_fg, herkunft_id, hackfleischpruef_fg, toleranz_unter_prozent, toleranz_ueber_prozent
) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.werk_id,
 V01.dme_einh_id,
 V01.tiergattung_id,
 V01.beschaffungsart_id,
 V01.zerlege_gruppe_id,
 COALESCE(V01.loesch_id, '') AS loesch_id,
 V01.dat_von_loesch_id,
 V01.indentifikation_fg,
 V01.tierkategorie_id,
 V01.herkunftsnachweis_fg,
 V01.herkunft_id,
 V01.hackfleischpruef_fg,
 V01.toleranz_unter_prozent,
 V01.toleranz_ueber_prozent
FROM kfl_production_dbp_view.v_flw_art_wup_status_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_werk_1 AS V02 ON V01.werk_id = V02.werk_id AND V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V02.flw_fg = 1;