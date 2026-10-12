CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_hydra_leistung_2 AS SELECT mandant_id,
 buchungskreis_id_hydra,
 produktivitaetsschl_hydra,
 lagernummer_id,
 transport_gv_id,
 belegart_id_hydra,
 wg_verkett_lief,
 dat,
 menge_1,
 dauer_1,
 menge_2,
 dauer_2,
 menge_3,
 dauer_3,
 menge_4,
 dauer_4
FROM kfl_production_dbp_view.v_hydra_leistung_2
WHERE abrechnung_fg = 1;