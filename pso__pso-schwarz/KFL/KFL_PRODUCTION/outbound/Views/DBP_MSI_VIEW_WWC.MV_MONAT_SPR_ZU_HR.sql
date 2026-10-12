CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_monat_spr_zu_hr (kjmo, gjmo, mo_id, mo_bez, spr_id) AS SELECT
 V01.kjmo,
 V01.gjmo,
 V02.mo_id,
 V02.mo_bez,
 V02.spr_id
FROM kfl_production_dbp_view.v_monat AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu AS V02 ON V01.mo_kj = V02.mo_id
WHERE V02.spr_id = 65
 AND V01.akt_kj BETWEEN - 3 AND 3;