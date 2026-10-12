CREATE OR REPLACE VIEW idq_production_kfl_ret_bg.mara_2 (mandt, matnr, ersda, ernam, laeda, aenam, vpsta, pstat, lvorm,
mtart, mbrsh, matkl, bismt, meins, bstme, zeinr, zeiar, zeivr, zeifo, aeszn, blatt, blanz, ferth, formt, groes, wrkst,
normt, labor, ekwsl, brgew, ntgew, gewei, volum, voleh, behvo, raube, tempb, disst, tragr, stoff, spart, kunnr, eannr,
wesch, bwvor, bwscl, saiso, etiar, etifo, entar, ean11, numtp, laeng, breit, hoehe, meabm, prdha, aeklk, cadkz, qmpur,
ergew, ergei, ervol, ervoe, gewto, volto, vabme, kzrev, kzkfg, xchpf, vhart, fuelg, stfak, magrv, begru, datab, liqdt,
saisj, plgtp, mlgut, extwg, satnr, attyp, kzkup, kznfm, pmata, mstae, mstav, mstde, mstdv, taklv, rbnrm, mhdrz, mhdhb,
mhdlp, inhme, inhal, vpreh, etiag, inhbr, cmeth, cuobf, kzumw, kosch, sprof, nrfhg, mfrpn, mfrnr, bmatn, mprof, kzwsm,
saity, profl, ihivi, iloos, serlv, kzgvh, xgchp, kzeff, compl, iprkz, rdmhd, przus, mtpos_mara, bflme, matfi, cmrel,
bbtyp, sled_bbd, gtin_variant, gennr, rmatp, gds_relevant, weora, hutyp_dflt, pilferable, whstc, whmatgr, hndlcode,
hazmat, hutyp, tare_var, maxc, maxc_tol, maxl, maxb, maxh, maxdim_uom, herkl, mfrgr, qqtime, qqtimeuom, qgrp, serial,
ps_smartform, logunit, cwqrel, cwqproc, cwqtolgr, adprof, ipmipproduct, allow_pmat_igno, medium, commodity,
animal_origin, textile_comp_ind, sgt_csgr, sgt_covsa, sgt_stat, sgt_scope, sgt_rel, fsh_mg_at1, fsh_mg_at2, fsh_mg_at3,
fsh_sealv, fsh_seaim, fsh_sc_mid, anp, psm_code, `_u002f_BEV1_u002f_LULEINH`, `_u002f_BEV1_u002f_LULDEGRP`,
`_u002f_BEV1_u002f_NESTRUCCAT`, `_u002f_DSD_u002f_SL_TOLTYP`, `_u002f_DSD_u002f_SV_CNT_GRP`, `_u002f_DSD_u002f_VC_GROUP`
, `_u002f_VSO_u002f_R_TILT_IND`, `_u002f_VSO_u002f_R_STACK_IND`, `_u002f_VSO_u002f_R_BOT_IND`, `_u002f_VSO_u002f_R_TOP_IND`
, `_u002f_VSO_u002f_R_STACK_NO`, `_u002f_VSO_u002f_R_PAL_IND`, `_u002f_VSO_u002f_R_PAL_OVR_D`, `_u002f_VSO_u002f_R_PAL_OVR_W`
, `_u002f_VSO_u002f_R_PAL_B_HT`, `_u002f_VSO_u002f_R_PAL_MIN_H`, `_u002f_VSO_u002f_R_TOL_B_HT`, `_u002f_VSO_u002f_R_NO_P_GVH`
, `_u002f_VSO_u002f_R_QUAN_UNIT`, `_u002f_VSO_u002f_R_KZGVH_IND`, packcode, dg_pack_status, mcond, retdelc, loglev_reto
, nsnid, adspc_spc, imatn, picnum, bstat, color_atinn, size1_atinn, size2_atinn, color, size1, size2, free_char,
care_code, brand_id, fiber_code1, fiber_part1, fiber_code2, fiber_part2, fiber_code3, fiber_part3, fiber_code4,
fiber_part4, fiber_code5, fiber_part5, fashgrd, td_insert, td_update, country_code) AS SELECT *
FROM idq_production_kfl_ret.mara_2
WHERE country_code IN ('BG', 'bg');