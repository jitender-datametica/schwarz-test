CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_KJMO_SPR_ZU
(
mo_bez
, mo_bez_de
, mo_bez_cz
, mo_bez_sk
, mo_bez_hr
, mo_bez_pl
, mo_bez_ro
, mo_bez_bg
, kjmo
, kj
, gjmo
, gj
, mo_bez_lang
, mo_bez_lang_de
, mo_bez_lang_cz
, mo_bez_lang_sk
, mo_bez_lang_hr
, mo_bez_lang_pl
, mo_bez_lang_ro
, mo_bez_lang_bg
)
AS
   SELECT
   --Cast(v01.kjmo_bez AS VARCHAR(40)) AS mo_bez
   Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.kjmo_bez  END),'N/A') AS mo_bez                                                          -- Standard == DE
   , Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.kjmo_bez  END),'N/A') AS mo_bez_de                                                     -- DE
   , Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.kjmo_bez  END), mo_bez_de) AS mo_bez_cz  -- CZ
   , Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.kjmo_bez  END), mo_bez_de) AS mo_bez_sk -- SK
   , Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.kjmo_bez  END), mo_bez_de) AS mo_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.kjmo_bez  END), mo_bez_de) AS mo_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.kjmo_bez  END), mo_bez_de) AS mo_bez_ro   -- RO
   , Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.kjmo_bez  END), mo_bez_de) AS mo_bez_bg  -- BG
   , v01.kjmo, Cast (SUBSTRING(v01.kjmo, 0, 4) AS SMALLINT) AS kj, v01.gjmo, Cast (SUBSTRING(v01.gjmo, 0, 4) AS SMALLINT) AS gj, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN kjmo_bez_lang END),'N/A') AS mo_bez_lang                                                  -- Standard == DE
   , Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN kjmo_bez_lang END),'N/A') AS mo_bez_lang_de                                             -- DE
   , Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN kjmo_bez_lang END), mo_bez_lang_de) AS mo_bez_lang_cz  -- CZ
   , Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN kjmo_bez_lang END), mo_bez_lang_de) AS mo_bez_lang_sk -- SK
   , Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN kjmo_bez_lang END), mo_bez_lang_de) AS mo_bez_lang_hr    -- HR
   , Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN kjmo_bez_lang END), mo_bez_lang_de) AS mo_bez_lang_pl    -- PL
   , Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN kjmo_bez_lang END), mo_bez_lang_de) AS mo_bez_lang_ro   -- RO
   , Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN kjmo_bez_lang END), mo_bez_lang_de) AS mo_bez_lang_bg  -- BG

   FROM dbp_view.v_kjmo_spr_zu v01
   GROUP BY
   kjmo
   , kj
   , gjmo
   ;