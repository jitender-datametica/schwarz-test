CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_gp_ek_infosatz (mandant_id, gp_id, art_id
, wup_id, nb_id, rundungsprofil, planlieferzeit, mind_bestellmenge) AS SELECT V01.mandant_id,
 V01.gp_id,
 V01.art_id,
 V02.wup_id,
 V02.nb_id,
 V02.rundungsprofil,
 V02.planlieferzeit,
 V02.mind_bestellmenge
FROM kfl_production_dbp_view.v_ek_infosatz AS V01
 INNER JOIN kfl_production_dbp_view.v_ek_infosatz_wup_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.ek_infosatz_id
    = V02.ek_infosatz_id
WHERE V02.nb_id = -111
 AND V01.dat_bis = DATE '9999-12-31'
 AND V01.loesch_fg = 0;