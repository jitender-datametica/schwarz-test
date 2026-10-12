CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_rauchverlust_1 (mandant_id, werk_id, dat_rauchvorgang,
zeit_rauchvorgang, in_art_id, rauchwagen_id, flw_arbeitsplatz1_id, gewicht_netto_in, gewicht_netto_out,
basismenge_einh_id, transport_einheit_id, flw_tenum_rauchprozess_kennzeichen, nettogew_diff_in_out) AS SELECT mandant_id
 ,
 werk_id,
 dat_rauchvorgang,
 zeit_rauchvorgang,
 flw_art_id AS in_art_id,
 rauchwagen_id,
 flw_arbeitsplatz1_id,
 nettogew_in AS gewicht_netto_in,
 nettogew_out AS gewicht_netto_out,
 basismenge_einh_id,
 transport_einheit_id,
 flw_tenum_rauchprozess_kennzeichen,
 nettogew_diff_in_out
FROM kfl_production_dbp_view.v_flw_rauchverlust_1 AS V01;