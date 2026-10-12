CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_bestellart_spr_zu_2 AS SELECT mandant_id,
 bestellart_id,
 spr_id,
 bestellart_bez
FROM kfl_production_dbp_view.v_bestellart_spr_zu_2 AS V01
UNION DISTINCT
SELECT V01.mandant_id,
 '-1' AS bestellart_id,
 V02.spr_id,
 'unbekannte Bestellart' AS bestellart_bez
FROM kfl_production_dbp_view.v_mandant_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V02 ON TRUE
GROUP BY V01.mandant_id,
 V02.spr_id,
 bestellart_id,
 bestellart_bez;