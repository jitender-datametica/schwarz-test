CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WUG_SPR_ZU_2
AS
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, v01.wug_id, max(coalesce(decode(position(wug_bez,upper(CASE WHEN v01.mandant_id = 1 then 'Gesperrt'
   WHEN v01.mandant_id = 2 then 'BLOKOVÁNO'
   WHEN v01.mandant_id = 3 then 'zablokowane'
   WHEN v01.mandant_id = 5 then 'Blokované'
   WHEN v01.mandant_id = 6 then 'ZATVORENO'
   WHEN v01.mandant_id = 7 then 'ÎNCHIS'
   WHEN v01.mandant_id = 8 then 'Блокирана' End)),1,1)  , 0)) as wug_gesperrt, COALESCE(MAX(CASE WHEN spr_id =  22 THEN wug_bez END),'N/A') AS wug_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN spr_id =  22 THEN wug_bez END),'N/A') AS wug_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN wug_bez END), wug_bez_de) AS wug_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN wug_bez END), wug_bez_de) AS wug_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65  THEN wug_bez END), wug_bez_de) AS wug_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90  THEN wug_bez END), wug_bez_de) AS wug_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95  THEN wug_bez END), wug_bez_de) AS wug_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18  THEN wug_bez END), wug_bez_de) AS wug_bez_bg  -- BG

   FROM dbp_view.v_wug_2 v01
   INNER JOIN dbp_view.v_wug_spr_zu_2 v02
   ON v01.wg_id = v02.wg_id AND v01.wug_id = v02.wug_id

   WHERE v01.arthiertyp_id = 2 and v02.arthiertyp_id = 2

   GROUP BY 1, 2, 3,4;