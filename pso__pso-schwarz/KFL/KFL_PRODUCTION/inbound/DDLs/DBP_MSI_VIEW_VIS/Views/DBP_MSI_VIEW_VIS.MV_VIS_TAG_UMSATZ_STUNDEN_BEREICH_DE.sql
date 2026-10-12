create or replace view DBP_MSI_VIEW_VIS.MV_VIS_TAG_UMSATZ_STUNDEN_BEREICH_DE(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	DAT,
	HR_OBJEKT_BEREICH_ID,
	HR_OBJEKT_BEREICH_BEZ,
	UMS_NETTO,
	UMS_NETTO_WVJ,
	UMS_NETTO_KVJ,
	STUNDEN_NETTO,
	STUNDEN_NETTO_PLAN,
	STUNDEN_SOLL_FIX,
	STUNDEN_SOLL_DYN,
	STUNDEN_SOLL
) as
   
   
   
   
   
   

   SELECT
   vis.mandant_id, 
   vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, vis.hr_objekt_bereich_id, '' AS hr_objekt_bereich_bez 
   , vis.ums_netto, vis.ums_netto_wvj, vis.ums_netto_kvj, (nsb.std_ist + sonst_ist)    AS stunden_netto       
   , (nsb.std_plan + sonst_plan)  AS stunden_netto_plan  
   , stunden_soll_fix, stunden_soll_dyn, stunden_soll
   FROM (
   SELECT 
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, -1::BYTEINT        AS hr_objekt_bereich_id, Sum(ums_netto)      AS ums_netto, Sum(ums_netto_wvj)  AS ums_netto_wvj, Sum(ums_netto_kvj)  AS ums_netto_kvj
   FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis
   WHERE vis.nb_id IN (-1, 0) AND vis.akt_gj BETWEEN -1 AND 1
   GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, hr_objekt_bereich_id

   UNION ALL
   SELECT 
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, 60::BYTEINT        AS hr_objekt_bereich_id, Sum(ums_netto)      AS ums_netto, Sum(ums_netto_wvj)  AS ums_netto_wvj, Sum(ums_netto_kvj)  AS ums_netto_kvj
   FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis
   WHERE vis.nb_id IN (-1, 0) AND vis.akt_gj BETWEEN -1 AND 1
   GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, hr_objekt_bereich_id

   UNION ALL
   SELECT 
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, 10::BYTEINT        AS hr_objekt_bereich_id, Sum(ums_netto)      AS ums_netto, Sum(ums_netto_wvj)  AS ums_netto_wvj, Sum(ums_netto_kvj)  AS ums_netto_kvj
   FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis

WHERE vis.nb_id = 0 AND vis.akt_gj BETWEEN -1 AND 1
GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, hr_objekt_bereich_id     
     
   UNION ALL
   SELECT 
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, 11::BYTEINT           AS hr_objekt_bereich_id, 0.00::DECIMAL (18,2)  AS ums_netto, 0.00::DECIMAL (18,2)  AS ums_netto_wvj, 0.00::DECIMAL (18,2)  AS ums_netto_kvj
     FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup vis

WHERE vis.nb_id = 0 AND vis.akt_gj BETWEEN -1 AND 1
     GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, hr_objekt_bereich_id

   UNION ALL
   SELECT 
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, ware.hr_objekt_bereich_id, Sum(ums_netto) ums_netto, Sum(ums_netto_wvj) ums_netto_wvj, Sum(ums_netto_kvj) ums_netto_kvj
   FROM dbp_msi_v_view.v_vis_tag_umsatz_wg vis
   JOIN (
   SELECT DISTINCT 
   owg.hr_objekt_bereich_id_de AS hr_objekt_bereich_id, wg.owg_id, wg.wg_id
   FROM dbp_view.v_wg_per  wg
   INNER JOIN dbp_view.v_owg_per owg
   ON owg.owg_id = wg.owg_id AND owg.dat_bis = '9999-12-31' AND owg.arthiertyp_id = 2
   ) ware
   ON ware.wg_id = vis.wg_id

   WHERE vis.nb_id IN (-1, 0)
   GROUP BY vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.dat, hr_objekt_bereich_id
   ) vis
   LEFT JOIN (
   SELECT DISTINCT 
   nsb.mandant_id, nsb.nb_id, nsb.wup_id, nsb.dat, nsb.hr_objekt_bereich_id, Sum(CASE WHEN stunden_typ_fg = 0 AND quelle_id IN (2,3,4) THEN stunden ELSE 0.00 END) AS std_ist, Sum(CASE WHEN stunden_typ_fg = 1 AND quelle_id IN (2,3,4) THEN stunden ELSE 0.00 END) AS std_plan, Sum(CASE WHEN stunden_typ_fg = 0 AND quelle_id NOT IN (2,3,4) THEN stunden ELSE 0.00 END) AS sonst_ist, Sum(CASE WHEN stunden_typ_fg = 1 AND quelle_id NOT IN (2,3,4) THEN stunden ELSE 0.00 END) AS sonst_plan
   FROM dbp_view.v_nettostunden_bereich  nsb
   GROUP BY nsb.mandant_id, nsb.nb_id, nsb.wup_id, nsb.dat, nsb.hr_objekt_bereich_id
   ) nsb
   ON nsb.wup_id = vis.wup_id AND nsb.mandant_id = vis.mandant_id AND nsb.dat = vis.dat
   AND nsb.hr_objekt_bereich_id = vis.hr_objekt_bereich_id
   LEFT JOIN (
   SELECT 
   ssm.mandant_id, ssm.wup_id, ssm.nb_id, ssm.dat, ssm_de.wup_bereich_id, CASE                                      
   WHEN ssm_de.wup_bereich_id = 5 THEN 10 
   WHEN ssm_de.wup_bereich_id = 3 THEN 30 
   WHEN ssm_de.wup_bereich_id = 6 THEN 31 
   WHEN ssm_de.wup_bereich_id = 1 THEN 40 
   WHEN ssm_de.wup_bereich_id = 4 THEN 60 
   ELSE -1
   END::BYTEINT AS hr_objekt_bereich_id, TRUNC( Sum(ssm.fixwert) / 100)                AS stunden_soll_fix, TRUNC( Sum(ssm.dynamischer_wert) / 100)       AS stunden_soll_dyn, (stunden_soll_fix + stunden_soll_dyn) AS stunden_soll
   FROM dbp_view.v_ssm_wup_tag_stunde ssm

   JOIN dbp_view.v_l_ssm_abteilung_de  ssm_de 

   ON ssm_de.wup_abt_id = ssm.wup_abt_id

   GROUP BY ssm.mandant_id, ssm.wup_id, ssm.nb_id, ssm.dat, ssm_de.wup_bereich_id
   ) ssm
   ON ssm.wup_id = vis.wup_id AND ssm.mandant_id = vis.mandant_id AND ssm.dat = vis.dat
   AND ssm.hr_objekt_bereich_id = vis.hr_objekt_bereich_id;