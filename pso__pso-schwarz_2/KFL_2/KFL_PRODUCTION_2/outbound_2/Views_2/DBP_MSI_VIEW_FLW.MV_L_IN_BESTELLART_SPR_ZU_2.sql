CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_bestellart_spr_zu_2 (mandant_id, bestellart_id,
bestell_typ_id, bestellart_bez, spr_id) AS SELECT V01.mandant_id,
 V01.bestellart_id,
 V01.bestell_typ_id,
 V01.bestellart_bez,
 V01.spr_id
FROM kfl_production_dbp_view.v_flw_bestellart_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2);