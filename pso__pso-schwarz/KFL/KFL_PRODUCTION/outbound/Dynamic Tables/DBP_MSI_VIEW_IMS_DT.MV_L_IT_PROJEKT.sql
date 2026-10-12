CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_it_projekt
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_projekt_id AS it_projekt_id,
  it_projekt_bez AS it_projekt_bez,
  it_projekt_status_id AS it_projekt_status_id,
  it_gremium_id AS it_gremium_id,
  it_projektart_id AS it_projektart_id,
  verrechnung_fg AS verrechnung_fg,
  dat_projekt_start AS dat_projekt_start,
  dat_projekt_ende AS dat_projekt_ende,
  dat_bericht_start AS dat_bericht_start,
  dat_bericht_ende AS dat_bericht_ende,
  einnahmen_entw_initial AS einnahmen_entw_initial,
  einsparungen_entw_initial AS einsparungen_entw_initial,
  einnahmen_betr_lfd_jahr1 AS einnahmen_betr_lfd_jahr1,
  einsparungen_betr_lfd_jahr1 AS einsparungen_betr_lfd_jahr1,
  einnahmen_betr_lfd_jahr2 AS einnahmen_betr_lfd_jahr2,
  einsparungen_betr_lfd_jahr2 AS einsparungen_betr_lfd_jahr2,
  einnahmen_betr_lfd_jahr3 AS einnahmen_betr_lfd_jahr3,
  einsparungen_betr_lfd_jahr3 AS einsparungen_betr_lfd_jahr3,
  einnahmen_betr_lfd_jahr4 AS einnahmen_betr_lfd_jahr4,
  einsparungen_betr_lfd_jahr4 AS einsparungen_betr_lfd_jahr4,
  einnahmen_betr_lfd_jahr5 AS einnahmen_betr_lfd_jahr5,
  einsparungen_betr_lfd_jahr5 AS einsparungen_betr_lfd_jahr5,
  einnahmen_betr_lfd_jahr6 AS einnahmen_betr_lfd_jahr6,
  einsparungen_betr_lfd_jahr6 AS einsparungen_betr_lfd_jahr6,
  einnahmen_betr_lfd_jahr7 AS einnahmen_betr_lfd_jahr7,
  einsparungen_betr_lfd_jahr7 AS einsparungen_betr_lfd_jahr7,
  nutzen_plan AS nutzen_plan
FROM kfl_production_dbp_view.v_it_projekt AS v01;
