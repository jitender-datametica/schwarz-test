CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_per_hist (mandant_id, art_id, dat, mutter_wb_id, posten_id
, ipn_id, mwst_id, oug_id) AS SELECT ARP.mandant_id,
 ARP.art_id,
 TG.dat,
 ARP.mutter_wb_id,
 ARP.posten_id,
 ARP.ipn_id,
 ARP.mwst_id,
 ARP.oug_id
FROM kfl_production_dbp_view.v_art_per AS ARP
 INNER JOIN kfl_production_dbp_view.v_tag AS TG ON ARP.dat_von <= TG.dat AND ARP.dat_bis >= TG.dat
WHERE TG.akt_gj BETWEEN - 3 AND 0
 AND TG.dat <= CURRENT_DATE;