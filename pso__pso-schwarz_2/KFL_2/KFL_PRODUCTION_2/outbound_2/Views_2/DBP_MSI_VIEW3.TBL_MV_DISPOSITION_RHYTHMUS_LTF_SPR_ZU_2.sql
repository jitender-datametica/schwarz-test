CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_disposition_rhythmus_ltf_spr_zu_2 (mandant_id, spr_id,
disposition_rhythmus_ltf_id, disposition_rhythmus_ltf_id_bez, disposition_rhythmus_ltf_bez) AS SELECT mandant_id,
 spr_id,
 disposition_rhythmus_ltf_id,
 SUBSTR(CAST(disposition_rhythmus_ltf_id AS STRING), 1, 14) AS disposition_rhythmus_ltf_id_bez,
 disposition_rhythmus_ltf_bez
FROM kfl_production_dbp_view.v_disposition_rhythmus_ltf_spr_zu_2 AS V01
UNION DISTINCT
SELECT V01.mandant_id,
 V02.spr_id,
 '-1' AS disposition_rhythmus_ltf_id,
 SUBSTR('nicht gepflegt', 1, 14) AS disposition_rhythmus_ltf_id_bez,
 'nicht gepflegt' AS disposition_rhythmus_ltf_bez
FROM kfl_production_dbp_view.v_mandant_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V02 ON TRUE;