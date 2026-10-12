CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_mass_typ_spr_zu_cz_1 AS SELECT DE.in_massnahme_typ_id,
 COALESCE(ls.in_massnahme_typ_bez, DE.in_massnahme_typ_bez) AS in_massnahme_typ_bez
FROM kfl_production_dbp_view.v_in_mass_typ_spr_zu_1 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_in_mass_typ_spr_zu_1
  WHERE spr_id = 124) AS ls ON DE.in_massnahme_typ_id = ls.in_massnahme_typ_id
WHERE DE.spr_id = 22;