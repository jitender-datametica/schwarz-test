CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_mes_arbeitsplatz_spr_zu_2 (mandant_id, flw_arbeitsplatz_id,
flw_arbeitsplatz_bez) AS SELECT V02.mandant_id,
 V02.flw_arbeitsplatz_id,
 V01.flw_arbeitsplatz_bez
FROM kfl_production_dbp_view.v_flw_mes_arbeitsplatz_schluessel_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_mes_arbeitsplatz_schluessel_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01
   .flw_arbeitsplatzschluessel_id = V02.flw_arbeitsplatzschluessel_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V03 ON V01.spr_id = V03.spr_id;