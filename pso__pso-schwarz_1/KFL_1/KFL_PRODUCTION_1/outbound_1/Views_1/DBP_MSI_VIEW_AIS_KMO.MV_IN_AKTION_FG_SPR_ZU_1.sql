CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_in_aktion_fg_spr_zu_1 (in_aktion_fg, in_aktion_fg_bez) AS
SELECT mandant_id - 1 AS in_aktion_fg,
  CASE
  WHEN mandant_id = 1
  THEN 'Nein'
  ELSE 'Ja'
  END AS in_aktion_fg_bez
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id <> 1;