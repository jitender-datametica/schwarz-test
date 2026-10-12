CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_DRUCK_ANLASS_SPR_ZU_2
AS
   -- 26.08.2019 snik1809 - Change in backend setup
   -- 2019-10-30 ssch0611 - update in data model

   SELECT
   druck_anlass_id, /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
  Max(CASE WHEN spr_id =  22 THEN druck_anlass_bez END)                                AS druck_anlass_bez_de,
 druck_anlass_bez_de                                                                  AS druck_anlass_bez       -- DE
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN druck_anlass_bez END), /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
 druck_anlass_bez_de) AS druck_anlass_bez_cz    -- CZ
   , Coalesce(Max(CASE WHEN spr_id = 108 THEN druck_anlass_bez END), /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
 druck_anlass_bez_de) AS druck_anlass_bez_sk    -- SK
   , Coalesce(Max(CASE WHEN spr_id =  65 THEN druck_anlass_bez END), /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
 druck_anlass_bez_de) AS druck_anlass_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN spr_id =  90 THEN druck_anlass_bez END), /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
 druck_anlass_bez_de) AS druck_anlass_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN spr_id =  95 THEN druck_anlass_bez END), /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
 druck_anlass_bez_de) AS druck_anlass_bez_ro    -- RO
   , Coalesce(Max(CASE WHEN spr_id =  18 THEN druck_anlass_bez END), /*Conversion issue - Severity Medium - 'druck_anlass_bez_de' has recursive references. Forward alias conversion could not be completed*/
 druck_anlass_bez_de) AS druck_anlass_bez_bg    -- BG
   
   FROM dbp_view.v_eps_druck_anlass_spr_zu_2

   GROUP BY druck_anlass_id;