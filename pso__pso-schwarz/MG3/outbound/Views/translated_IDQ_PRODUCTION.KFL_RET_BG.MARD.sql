CREATE OR REPLACE VIEW idq_production_kfl_ret_bg.mard (mandt, matnr, werks, lgort, pstat, lvorm, lfgja, lfmon, sperr,
labst, umlme, insme, einme, speme, retme, vmlab, vmuml, vmins, vmein, vmspe, vmret, kzill, kzilq, kzile, kzils, kzvll,
kzvlq, kzvle, kzvls, diskz, lsobs, lminb, lbstf, herkl, exppg, exver, lgpbe, klabs, kinsm, keinm, kspem, dlinl, prctl,
ersda, vklab, vkuml, lwmkb, bskrf, mdrue, mdjin, dummy_stl_incl_eew_ps, fsh_salloc_qty_s, cwm_labst, cwm_insme,
cwm_einme, cwm_speme, cwm_retme, cwm_umlme, cwm_klabs, cwm_kinsm, cwm_keinm, cwm_kspem, cwm_vmlab, cwm_vmins, cwm_vmein
, cwm_vmspe, cwm_vmret, cwm_vmuml, country_code, td_insert, td_update) AS SELECT *
FROM idq_production_kfl_ret.mard
WHERE country_code IN ('BG', 'bg');