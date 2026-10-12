CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_HWG_WG_SPR_ZU_2
(
hwg_id
, hwg_bez
, hwg_bez_de
, hwg_bez_cz
, hwg_bez_sk
, hwg_bez_hr
, hwg_bez_pl
, hwg_bez_ro
, hwg_bez_bg
, owg_id
, owg_bez
, owg_bez_de
, owg_bez_cz
, owg_bez_sk
, owg_bez_hr
, owg_bez_pl
, owg_bez_ro
, owg_bez_bg
, wg_id
, wg_bez
, wg_bez_de
, wg_bez_cz
, wg_bez_sk
, wg_bez_hr
, wg_bez_pl
, wg_bez_ro
, wg_bez_bg
, mandant_id
, arthiertyp_id
)
AS
   SELECT
   v01.hwg_id, Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v02.hwg_bez END),'N/A') AS hwg_bez                                                             -- Standard == DE
   , Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v02.hwg_bez END),'N/A') AS hwg_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v02.spr_id = 124 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v02.spr_id = 108 THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v02.spr_id =  65  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v02.spr_id =  90  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v02.spr_id =  95  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v02.spr_id =  18  THEN v02.hwg_bez END), hwg_bez_de) AS hwg_bez_bg  -- BG
   , v03.owg_id, Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v04.owg_bez END),'N/A') AS owg_bez                                                             -- Standard == DE
   , Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v04.owg_bez END),'N/A') AS owg_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v02.spr_id = 124 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v02.spr_id = 108 THEN v04.owg_bez END), owg_bez_de) AS owg_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v02.spr_id =  65  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v02.spr_id =  90  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v02.spr_id =  95  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v02.spr_id =  18  THEN v04.owg_bez END), owg_bez_de) AS owg_bez_bg  -- BG
   , v05.wg_id, Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v06.wg_bez END),'N/A') AS wg_bez                                                             -- Standard == DE
   , Coalesce(Max(CASE WHEN v02.spr_id =  22  THEN v06.wg_bez END),'N/A') AS wg_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v02.spr_id = 124 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v02.spr_id = 108 THEN v06.wg_bez END), wg_bez_de) AS wg_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v02.spr_id =  65  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v02.spr_id =  90  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v02.spr_id =  95  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v02.spr_id =  18  THEN v06.wg_bez END), wg_bez_de) AS wg_bez_bg  -- BG
   , v01.mandant_id, v01.arthiertyp_id

   --hwg_id
   FROM
   dbp_view.v_hwg_per_2 v01
   INNER JOIN dbp_view.v_hwg_spr_zu_2 v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   INNER JOIN dbp_view.v_owg_per_2 v03
   ON v03.mandant_id = v01.mandant_id
   AND v03.hwg_id = v01.hwg_id
   INNER JOIN dbp_view.v_owg_spr_zu_2 v04
   ON v04.mandant_id = v03.mandant_id
   AND v04.owg_id = v03.owg_id
   INNER JOIN dbp_view.v_wg_per_2 v05
   ON v05.mandant_id = v03.mandant_id
   AND v05.owg_id = v03.owg_id
   INNER JOIN dbp_view.v_wg_spr_zu_2 v06
   ON v06.mandant_id = v05.mandant_id
   AND v06.wg_id = v05.wg_id

   WHERE v01.arthiertyp_id = 2 AND v01.dat_bis = '9999-12-31'

   GROUP BY
   v01.hwg_id
   , v03.owg_id
   , v05.wg_id
   , v01.mandant_id
   , v01.arthiertyp_id;