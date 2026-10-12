CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_as_food (art_id, mandant_id, nb_id, wup_id, dat_auslistung,
gp_id, phase_status, erl_fg, dat_final, menge_startbestand, vk_netto, menge_endbestand, erl_kz, dat_aend, prozess_aktiv
) AS SELECT art_id,
 mandant_id,
 nb_id,
 wup_id,
 dat_auslistung,
 gp_id,
 phase_status,
 erl_fg,
 dat_final,
 menge_startbestand,
 vk_netto,
 menge_endbestand,
 erl_kz,
 dat_aend,
  CASE
  WHEN dat_final < CURRENT_DATE AND erl_fg <> 0
  THEN 'X'
  ELSE '0'
  END AS prozess_aktiv
FROM kfl_production_dbp_view.v_as_food AS V01
WHERE phase_status = 1;