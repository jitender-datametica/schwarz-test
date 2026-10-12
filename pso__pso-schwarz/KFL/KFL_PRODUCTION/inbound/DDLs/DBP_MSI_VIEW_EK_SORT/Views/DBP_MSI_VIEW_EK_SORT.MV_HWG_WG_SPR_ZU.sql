CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_HWG_WG_SPR_ZU
AS

   SELECT

   v01.hwg_id, COALESCE(MAX(CASE WHEN v02.spr_id =  22  THEN v02.hwg_bez  END),'N/A') AS hwg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id =  22  THEN v02.hwg_bez END),'N/A') AS hwg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id =  65  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id =  90  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id =  95  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id =  18  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_bg  -- BG
   , v03.owg_id, COALESCE(MAX(CASE WHEN v04.spr_id =  22  THEN v04.owg_bez  END),'N/A') AS owg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v04.spr_id =  22  THEN v04.owg_bez END),'N/A') AS owg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v04.spr_id = 124 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v04.spr_id = 108 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v04.spr_id =  65  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v04.spr_id =  90  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v04.spr_id =  95  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v04.spr_id =  18  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_bg  -- BG
   , v05.wg_id, COALESCE(MAX(CASE WHEN v06.spr_id =  22  THEN v06.wg_bez  END),'N/A') AS wg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN v06.spr_id =  22  THEN v06.wg_bez END),'N/A') AS wg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN v06.spr_id = 124 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN v06.spr_id = 108 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN v06.spr_id =  65  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v06.spr_id =  90  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v06.spr_id =  95  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN v06.spr_id =  18  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_bg  -- BG
   , v01.mandant_id

   --hwg_id
   FROM
   dbp_view.v_hwg_per v01
   INNER JOIN dbp_view.v_hwg_spr_zu v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   INNER JOIN dbp_view.v_owg_per v03
   ON v03.mandant_id = v01.mandant_id
   AND v03.hwg_id = v01.hwg_id
   AND CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
   INNER JOIN dbp_view.v_owg_spr_zu v04
   ON v04.mandant_id = v03.mandant_id
   AND v04.owg_id = v03.owg_id
   INNER JOIN dbp_view.v_wg_per v05
   ON v05.mandant_id = v03.mandant_id
   AND v05.owg_id = v03.owg_id
   AND CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis
   INNER JOIN dbp_view.v_wg_spr_zu v06
   ON v06.mandant_id = v05.mandant_id
   AND v06.wg_id = v05.wg_id

   WHERE CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis

   GROUP BY
   v01.hwg_id
   ,v03.owg_id
   ,v05.wg_id
   ,v01.mandant_id;