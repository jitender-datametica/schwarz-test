CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EPS_CONTAINERTYP_SPR_ZU
AS
   -- 14.03.2019 dsim0608 - SPEC0049429
   -- 26.08.2019 snik1809 - Change in backend setup
   -- 2019-10-30 ssch0611 - update in data model, mandant removed

   SELECT DISTINCT
   containertyp_id, /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
    Max(CASE WHEN spr_id = 22 THEN containertyp_bez END)                                 AS containertyp_bez_de,
 containertyp_bez_de                                                                  AS containertyp_bez       -- DE
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN containertyp_bez END), /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
 containertyp_bez_de) AS containertyp_bez_cz    -- CZ
   , Coalesce(Max(CASE WHEN spr_id = 108 THEN containertyp_bez END), /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
 containertyp_bez_de) AS containertyp_bez_sk    -- SK
   , Coalesce(Max(CASE WHEN spr_id =  65 THEN containertyp_bez END), /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
 containertyp_bez_de) AS containertyp_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN spr_id =  90 THEN containertyp_bez END), /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
 containertyp_bez_de) AS containertyp_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN spr_id =  95 THEN containertyp_bez END), /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
 containertyp_bez_de) AS containertyp_bez_ro    -- RO
   , Coalesce(Max(CASE WHEN spr_id =  18 THEN containertyp_bez END), /*Conversion issue - Severity Medium - 'containertyp_bez_de' has recursive references. Forward alias conversion could not be completed*/
 containertyp_bez_de) AS containertyp_bez_bg    -- BG
   

   FROM dbp_view.v_eps_containertyp_spr_zu

   GROUP BY containertyp_id;