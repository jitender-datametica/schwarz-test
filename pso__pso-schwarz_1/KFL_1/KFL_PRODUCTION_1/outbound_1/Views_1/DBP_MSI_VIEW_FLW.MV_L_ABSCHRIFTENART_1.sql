CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_abschriftenart_1 (abschriftart_id, abschriftart_bez,
mandant_id, spr_id) AS SELECT V01.abschriftart_id,
 V01.abschriftart_bez,
 V01.mandant_id,
 V01.spr_id
FROM kfl_production_dbp_view.v_abschriftart_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id = 1
UNION DISTINCT
SELECT V01.preis_aend_grund_id AS abschriftart_id,
 V01.preis_aend_grund_bez AS abschriftart_bez,
 V01.mandant_id,
 V01.spr_id
FROM kfl_production_dbp_view.v_preis_aenderung_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id = 2;