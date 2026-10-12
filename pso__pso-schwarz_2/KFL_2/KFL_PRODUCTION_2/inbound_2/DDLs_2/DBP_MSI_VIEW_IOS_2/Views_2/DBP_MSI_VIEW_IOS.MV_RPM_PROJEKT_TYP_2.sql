CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_PROJEKT_TYP_2 --

AS
   -- LOOKUP/SPRACHE - RPM Maßnahmetyp
   -- einamliger, manueller Abzug aus RPM
   -- 20160318 ssch0611 : Initial
   -- 20160822 ssch0611 : Erweiterung Projekt Kategorie (Zuordnung)
   -- 20161221 kkaiser: ZPPM_ ausgebaut (BE- seitig ist schon)
   -- 20190211 msar2108: Bezeichnung aus Massnahmenart
   -- 20190213 nfis0811: Anpassungen Mobile + Internationalisierung Bez

   SELECT DISTINCT
   lrp.rpm_projekt_typ_id, rpm_projekt_typ_id                        AS rpm_projekt_typ, CASE
   WHEN lrp.rpm_projekt_typ_id IN ( 'DM','FM','LM','NB_2','UB','UE','XP' ) THEN '1EX'
   WHEN lrp.rpm_projekt_typ_id IN ( 'MM_2','MO','RE_2','RN','ST' ) THEN '2MM_2'
   WHEN lrp.rpm_projekt_typ_id IN ( 'IG','PM_2' ) THEN '3IG'
   WHEN lrp.rpm_projekt_typ_id IN ( 'BM','SM_2','WM_2' ) THEN '4SB'
   WHEN lrp.rpm_projekt_typ_id IN ( 'GM','KM' ) THEN '5KM'
   WHEN lrp.rpm_projekt_typ_id IN ( 'KO' ) THEN '6KO'
   WHEN lrp.rpm_projekt_typ_id IN ( 'DB','FB','FK','LB','LK','LO','NF','NV','NW','RF','RL','RS_2','RV','SF','VK_2','WR' ) THEN '7LF'
   ELSE '8SO'
   END::VARCHAR(4) AS rpm_projekt_kat, MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END) AS rpm_projekt_typ_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN ms.spr_id = 124 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN ms.spr_id = 108 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN ms.spr_id = 65 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN ms.spr_id = 90 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN ms.spr_id = 95 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN ms.spr_id = 24 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN ms.spr_id = 18 THEN massnahmenart_bez ELSE NULL END), MAX(CASE WHEN ms.spr_id =  22 THEN massnahmenart_bez ELSE NULL END)) AS rpm_projekt_typ_bez_bg    -- BG


   FROM dbp_view.v_l_rpm_phase_2  lrp
   JOIN dbp_view.v_l_massnahme_2 lm
   ON lrp.rpm_projekt_typ_id = lm.massnahme_id
   JOIN dbp_view.v_massnahmenart_spr_zu_2 ms
   ON lm.massnahmenart_id = ms.massnahmenart_id


   --WHERE CHARACTER(Trim(rpm_projekt_typ_id)) BETWEEN 2 AND 3  -- nur gueltige Projekte;
   WHERE LEN(Trim(rpm_projekt_typ_id)) BETWEEN 2 AND 3  -- nur gueltige Projekte;
   GROUP BY 1,2,3;