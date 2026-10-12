CREATE OR REPLACE VIEW idq_production_kfl_ret_de.mvke_1 (mandt, matnr, vkorg, vtweg, lvorm, versg, bonus, provg, sktof,
vmsta, vmstd, aumng, lfmng, efmng, scmng, schme, vrkme, mtpos, dwerk, prodh, pmatn, kondm, ktgrm, mvgr1, mvgr2, mvgr3,
mvgr4, mvgr5, sstuf, pflks, lstfl, lstvz, lstak, ldvfl, ldbfl, ldvzl, ldbzl, vdvfl, vdbfl, vdvzl, vdbzl, prat1, prat2,
prat3, prat4, prat5, prat6, prat7, prat8, prat9, prata, rdprf, megru, lfmax, rjart, pbind, vavme, matkc, pvmso,
`_u002f_BEV1_u002f_EMLGRP`, `_u002f_BEV1_u002f_EMDRCKSPL`, `_u002f_BEV1_u002f_RPBEZME`, `_u002f_BEV1_u002f_RPSNS`,
`_u002f_BEV1_u002f_RPSFA`, `_u002f_BEV1_u002f_RPSKI`, `_u002f_BEV1_u002f_RPSCO`, `_u002f_BEV1_u002f_RPSSO`, plgtp,
zzek_sstuf, zzsopo, zzlabpr, zzwerb, zznoass, zzstawn, zzvkwerb, country_code, td_insert, td_update) AS SELECT *
FROM idq_production_kfl_ret.mvke_1
WHERE country_code IN ('DE', 'de');