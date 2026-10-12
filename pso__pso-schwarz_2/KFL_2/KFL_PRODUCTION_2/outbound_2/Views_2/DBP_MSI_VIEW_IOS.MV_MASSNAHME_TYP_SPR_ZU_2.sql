CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_massnahme_typ_spr_zu_2 (in_massnahme_typ_id,
in_massnahme_typ_bez) AS SELECT massnahmentyp_id AS in_massnahme_typ_id,
 massnahmentyp_bez AS in_massnahme_typ_bez
FROM kfl_production_dbp_view.v_massnahmentyp_spr_zu_2 AS V01
WHERE spr_id = 22;