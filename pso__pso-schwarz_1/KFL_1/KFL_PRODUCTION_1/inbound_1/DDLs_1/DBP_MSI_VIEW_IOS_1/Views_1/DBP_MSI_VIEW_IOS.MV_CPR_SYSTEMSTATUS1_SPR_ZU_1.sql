CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_SYSTEMSTATUS1_SPR_ZU_1
(

--20170425 hmue2308: Redesign IOS
--AP0004982, SPEC0020558
--Seperate View für Systemstatus
--20180214 nfis0811 - SPEC0033999 Erweiterung Systemstatus um Ausprägung 4
--20180223 nfis0811: Erweiterung für (Spalten)-Internationalisierung

cpr_systemstatus1_id
,cpr_systemstatus1_bez
--spr_id
,cpr_systemstatus1_bez_cz
,cpr_systemstatus1_bez_sk
,cpr_systemstatus1_bez_hr
,cpr_systemstatus1_bez_pl
,cpr_systemstatus1_bez_ro
,cpr_systemstatus1_bez_en
,cpr_systemstatus1_bez_bg


)
AS

   SELECT

   v01.cpr_systemstatus1_id, MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END) AS cpr_systemstatus1_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN cpr_systemstatus1_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cpr_systemstatus1_bez ELSE NULL END)) AS cpr_systemstatus1_bez_bg    -- BG


   FROM dbp_view.v_cpr_systemstatus1_spr_zu_1 v01

   WHERE --v01.spr_id = 22 and
   v01.cpr_systemstatus1_id IN (1,2,3,4)
   GROUP BY 1;