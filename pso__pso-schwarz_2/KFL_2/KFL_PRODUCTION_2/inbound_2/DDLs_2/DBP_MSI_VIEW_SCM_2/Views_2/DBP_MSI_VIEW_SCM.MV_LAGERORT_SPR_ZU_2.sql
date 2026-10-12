CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_LAGERORT_SPR_ZU_2 as
   SELECT
     v01.mandant_id, v01.lagerort_id, v01.nb_id, v01.wup_id, v01.wup_id||' '||(MAX(CASE WHEN v01.spr_id =  22 THEN coalesce(v02.lagerort_bez,v01.lagerort_bez) END)) AS lagerort_bez, MAX(CASE WHEN v01.spr_id =  22 THEN coalesce(v02.lagerort_bez,v01.lagerort_bez) END) AS lagerort_bez_de, v01.wup_id||' '||(COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.lagerort_bez END), lagerort_bez_de)) AS lagerort_bez_cz    -- CZ
   , v01.wup_id||' '||(COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.lagerort_bez END), lagerort_bez_de)) AS lagerort_bez_sk    -- SK
   , v01.wup_id||' '||(COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.lagerort_bez END), lagerort_bez_de)) AS lagerort_bez_hr    -- HR
   , v01.wup_id||' '||(COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.lagerort_bez END), lagerort_bez_de)) AS lagerort_bez_pl    -- PL
   , v01.wup_id||' '||(COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.lagerort_bez END), lagerort_bez_de)) AS lagerort_bez_ro    -- RO
   , v01.wup_id||' '||(COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.lagerort_bez END), lagerort_bez_de)) AS lagerort_bez_bg    -- BG
   FROM dbp_view.v_lagerort_spr_zu_2 v01
   LEFT OUTER JOIN dbp_msi_view3.ts_lagerort_altn_spr_zu_2 v02
   ON v01.mandant_id=v02.mandant_id and v01.wup_id=v02.wup_id and v01.lagerort_id=v02.lagerort_id and v01.spr_id=v02.spr_id
   WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3')
   GROUP BY
     v01.mandant_id
   , v01.lagerort_id
   , v01.nb_id
   , v01.wup_id;