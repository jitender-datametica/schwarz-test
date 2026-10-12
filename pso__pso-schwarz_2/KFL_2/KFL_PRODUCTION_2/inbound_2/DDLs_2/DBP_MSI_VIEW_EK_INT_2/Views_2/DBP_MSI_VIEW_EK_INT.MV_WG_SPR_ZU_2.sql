CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WG_SPR_ZU_2
AS
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.wg_id, max(coalesce(decode(position(wg_bez,upper(CASE WHEN v01.mandant_id = 1 then 'Gesperrt'
   WHEN v01.mandant_id = 2 then 'BLOKOVÁNO'
   WHEN v01.mandant_id = 3 then 'zablokowane'
   WHEN v01.mandant_id = 5 then 'Blokované'
   WHEN v01.mandant_id = 6 then 'ZATVORENO'
   WHEN v01.mandant_id = 7 then 'ÎNCHIS'
   WHEN v01.mandant_id = 8 then 'Блокирана' End)),1,1)  , 0)) as wg_gesperrt, COALESCE(MAX(CASE WHEN spr_id =  22 THEN wg_bez END),'N/A') AS wg_bez                                                             -- Standard == DE
   , COALESCE(MAX(CASE WHEN spr_id =  22 THEN wg_bez END),'N/A') AS wg_bez_de                                                     -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN wg_bez END), wg_bez_de) AS wg_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN wg_bez END), wg_bez_de) AS wg_bez_sk -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65  THEN wg_bez END), wg_bez_de) AS wg_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90  THEN wg_bez END), wg_bez_de) AS wg_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95  THEN wg_bez END), wg_bez_de) AS wg_bez_ro   -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18  THEN wg_bez END), wg_bez_de) AS wg_bez_bg  -- BG

   FROM dbp_view.v_wg_per_2 v01
   INNER JOIN dbp_view.v_wg_spr_zu_2  v02
   ON  v01.wg_id = v02.wg_id

   WHERE v01.arthiertyp_id = 2 and v02.arthiertyp_id = 2

   GROUP BY 1, 2, 3;