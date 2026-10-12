CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_haupt_wup_1 AS SELECT DISTINCT mandant_id,
 land_id,
 nb_id AS haupt_nb_id,
 haupt_wup_id,
 wup_standort AS haupt_wup_standort,
 eigentum_miete_kz AS haupt_eigentum_miete,
 dat_steckbrief AS haupt_dat_steckbrief,
 dat_geschlossen AS haupt_dat_geschlossen,
 dat_letzte_modernisierung_von AS haupt_dat_mod_von,
 dat_letzte_modernisierung_bis AS haupt_dat_mod_bis,
 dat_letzter__facelift_von AS haupt_dat_fcl_von,
 dat_letzter_facelift AS haupt_dat_fcl,
 umsatz_erwartung_eur AS haupt_ums_erwart_eur,
 einwohner_anzahl AS haupt_ew_anzahl,
     TRIM(land_id) || ' ' || TRIM(SUBSTR(CAST(wup_id AS STRING), 1, 39)) || ' ' || TRIM(wup_standort) AS haupt_wup_bez
FROM kfl_production_dbp_msi_view_vis.mv_wup_1 AS WW
WHERE wup_id = haupt_wup_id
 AND nb_id IN (0, - 1);